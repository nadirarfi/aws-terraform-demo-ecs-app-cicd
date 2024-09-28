#!/bin/bash

####################################################################################################
############## Deploy all resources using apply-auto-approve
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

# Function to apply Terraform actions with error handling
deploy_all() {
    local env=$1
    local resource_groups=(${env_resource_mapping[$env]})

    for group in "${resource_groups[@]}"; do
        declare -n resources="$group"  # Use declare -n for indirect expansion (Bash 4.3+)

        for resource in "${resources[@]}"; do
            echo "Applying $env $resource"
            ./tf.sh apply-auto-approve "$env" "$resource"
            if [ $? -ne 0 ]; then
                echo "Error: Terraform failed while applying $env $resource"
                exit 1
            fi
        done
    done
}

# Apply resources for dev and prod environments
deploy_all "dev"
deploy_all "prod"
deploy_all "shared"
