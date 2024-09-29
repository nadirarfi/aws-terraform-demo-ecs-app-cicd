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
# - Handles different environments such as `dev`, `prod`, `shared`, etc., defined in the JSON file.
#
# JSON File Structure (`json/resources.json`):
#
# {
#   "dev": {
#     "infrastructure_resources": ["vpc", "security_groups", "alb_target_groups", "alb", "ecs_cluster", "db"],
#     "application_resources": ["backend", "frontend"]
#   },
#   "prod": {
#     "infrastructure_resources": ["vpc", "security_groups", "alb", "db"],
#     "application_resources": ["backend", "frontend"]
#   },
#   "shared": {
#     "cicd_resources": ["codebuild", "codedeploy", "codepipeline"]
#   }
# }
#
# Usage:
# ./deploy.sh <action>
# - <action> can be one of: `apply`, `destroy`, `plan`.
#
# Example:
# ./deploy.sh apply
# ./deploy.sh destroy
# ./deploy.sh plan
#
####################################################################################################

# Load helper functions (assuming they are in helpers/functions.sh)
source ./helpers/functions.sh

# Function to load environments from the single JSON file
load_environments_from_json() {
    local json_file="./json/resources.json"

    if [ ! -f "$json_file" ]; then
        echo "Error: JSON file $json_file not found!"
        exit 1
    fi

    # Extract the environment names from the top-level keys and store them in an array
    environments=($(jq -r 'keys[]' "$json_file"))
}

# Function to load resource groups and their resources for a given environment
load_resources_from_json() {
    local env=$1
    local json_file="./json/resources.json"

    # Extract the resource groups for the given environment and store them in an array
    resource_groups=($(jq -r "keys[]" "$json_file" | jq ".${env}"))
}

# Function to load resources for a specific resource group
load_resources_for_group() {
    local env=$1
    local group=$2
    local json_file="./json/resources.json"

    # Return the resources for the given environment and group as an array
    jq -r ".${env}.${group}[]" "$json_file"
}

# Function to perform Terraform actions with error handling
terraform_action() {
    local action=$1
    local env=$2
    local resource=$3

    # Handle special cases for apply, destroy, and plan
    case "$action" in
        apply)
            echo "Running Terraform apply-auto-approve for $env $resource"
            ./tf.sh apply-auto-approve "$env" "$resource"
            ;;
        destroy)
            echo "Running Terraform destroy-auto-approve for $env $resource"
            ./tf.sh destroy-auto-approve "$env" "$resource"
            ;;
        plan)
            echo "Running Terraform plan for $env $resource"
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
    for (( i=${#array[@]}-1; i>=0; i-- )); do
        echo "${array[i]}"
    done
}

# Function to manage resources for a given environment
manage_resources() {
    local action=$1
    local env=$2

    # Load resource groups and resources from the environment in the JSON file
    load_resources_from_json "$env"

    # If action is destroy, reverse the resource groups order
    if [ "$action" == "destroy" ]; then
        resource_groups=($(reverse_array "${resource_groups[@]}"))
    fi

    # Loop over each resource group
    for group in "${resource_groups[@]}"; do
        # Load the resources in the group
        resources=($(load_resources_for_group "$env" "$group"))

        # If action is destroy, reverse the order of resources in each group
        if [ "$action" == "destroy" ]; then
            resources=($(reverse_array "${resources[@]}"))
        fi

        # Apply Terraform actions to each resource in the group
        for resource in "${resources[@]}"; do
            terraform_action "$action" "$env" "$resource"
        done
    done
}

# Main function to process action and environment dynamically
main() {
    local action=$1

    if [[ -z "$action" ]]; then
        echo "Usage: $0 <action>"
        exit 1
    fi

    # Load environments dynamically from the single JSON file
    load_environments_from_json

    # Loop through each environment and manage its resources
    for env in "${environments[@]}"; do
        echo "Processing environment: $env"
        manage_resources "$action" "$env"
    done
}

# Call the main function with the action passed as an argument
# Example usage: ./deploy.sh apply
main "$@"
