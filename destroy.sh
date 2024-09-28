#!/bin/bash

####################################################################################################
############## Deploy all resources using destroy-auto-approve
####################################################################################################

cd terraform

# Define resources for each category
infrastructure_resources=(
    "vpc"
    "security_groups"
    "alb_target_groups"
    "alb"
    "ecs_cluster"
    "db"
)

application_resources=(
    "backend"
    "frontend"
)

cicd_resources=(
    "codebuild"
    "codedeploy"
    "codepipeline"
)

# Define environments and their associated resource types
declare -A env_resource_mapping=(
    [dev]="infrastructure_resources application_resources"
    [prod]="infrastructure_resources application_resources"
    [shared]="cicd_resources"
)

# Function to destroy Terraform actions with error handling
destroy_all() {
    local env=$1
    local resource_groups=(${env_resource_mapping[$env]})

    for group in "${resource_groups[@]}"; do
        declare -n resources="$group" # Use declare -n for indirect expansion (Bash 4.3+)

        # Loop through the resources array in reverse order
        for ((i = ${#resources[@]} - 1; i >= 0; i--)); do
            resource="${resources[$i]}"
            echo "Destroying $env $resource"
            ./tf.sh destroy-auto-approve "$env" "$resource"
            if [ $? -ne 0 ]; then
                echo "Error: Terraform failed while destroying $env $resource"
                exit 1
            fi
        done
    done
}

# Apply resources for dev and prod environments
destroy_all "shared"
destroy_all "dev"
destroy_all "prod"
