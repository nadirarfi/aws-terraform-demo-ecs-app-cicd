#!/bin/bash

####################################################################################################
############## Reusable Terraform actions with a single resources.json file (with reverse destroy)
####################################################################################################
# Description:
# This script automates Terraform actions (apply, destroy, plan) for multiple environments 
# and resource groups, driven by a single `resources.json` file. 
# 
# The script supports:
# 1. `apply-auto-approve`: Applies Terraform configurations automatically.
# 2. `destroy-auto-approve`: Destroys Terraform-managed infrastructure in reverse order 
#    (to avoid dependency issues), automatically.
# 3. `plan`: Generates and shows an execution plan for Terraform, without making changes.
#
# Features:
# - Dynamically loads environments and resources from a single JSON file.
# - For `destroy` actions, the script ensures that resources are removed in reverse order.
#
# JSON File Structure (`json/resources.json`):
#
# {
#   "dev": {
#     "infrastructure": ["vpc", "security_groups", "alb_target_groups", "alb", "ecs_cluster", "db"],
#     "application": ["backend", "frontend"]
#   },
#   "prod": {
#     "infrastructure": ["vpc", "security_groups", "alb", "db"],
#     "application": ["backend", "frontend"]
#   },
#   "shared": {
#     "cicd": ["codebuild", "codedeploy", "codepipeline"]
#   }
# }
#
# Usage:
# ./deploy.sh <action>
# - <action> can be one of: `apply`, `destroy`, `plan`.
#
####################################################################################################

# Load helper functions (assuming they are in helpers/functions.sh)
source ./helpers/functions.sh

# Function to perform Terraform actions
terraform_action() {
    local action=$1
    local env=$2
    local resource=$3

    echo "Running Terraform $action for $env $resource"
    case "$action" in
        apply)
            ./tf.sh apply-auto-approve "$env" "$resource"
            ;;
        destroy)
            ./tf.sh destroy-auto-approve "$env" "$resource"
            ;;
        plan)
            ./tf.sh plan "$env" "$resource"
            ;;
        *)
            echo "Invalid action: $action"
            exit 1
            ;;
    esac

    # Check for errors
    if [ $? -ne 0 ]; then
        echo "Error: Terraform failed while running $action for $env $resource"
        exit 1
    fi
}

# Function to reverse the order of an array (helper function for destroy action)
reverse_array() {
    local array=("$@")
    local reversed=()
    for (( i=${#array[@]}-1; i>=0; i-- )); do
        reversed+=("${array[i]}")
    done
    echo "${reversed[@]}"
}

# Main function to process action and environment dynamically
main() {
    local action=$1

    if [[ -z "$action" ]]; then
        echo "Usage: $0 <action>"
        exit 1
    fi

    # Load the JSON file
    local json_file="./json/resources.json"
    if [ ! -f "$json_file" ]; then
        echo "Error: JSON file $json_file not found!"
        exit 1
    fi

    # Extract the environment names from the top-level keys
    environments=$(jq -r 'to_entries[] | .key' "$json_file")
    echo $environments

    # Reverse the order of environments if action is destroy
    [ "$action" == "destroy" ] && environments=$(reverse_array $environments)

    # Process each environment
    for env in $environments; do
        # Extract resource groups for the environment
        resource_groups=$(jq -r ".[\"${env}\"] | to_entries[] | .key" "$json_file")

        # Reverse the resource groups if action is destroy
        [ "$action" == "destroy" ] && resource_groups=$(reverse_array $resource_groups)

        # Process each resource group
        for group in $resource_groups; do
            resources=$(jq -r ".${env}.${group}[]" "$json_file")

            # Reverse resources if action is destroy
            [ "$action" == "destroy" ] && resources=$(reverse_array $resources)

            # Apply Terraform actions to each resource
            for resource in $resources; do
                terraform_action "$action" "$env" "$resource"
            done
        done
    done
}

# Call the main function with the action passed as an argument
main "$@"
