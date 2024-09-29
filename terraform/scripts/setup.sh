#!/bin/bash

####################################################################################
############## Configuration
####################################################################################

# Load environment-specific variables from shared.yml
SHARED_CONFIG=../config/shared.yml
TEST_CONFIG=../config/test.yml
PROD_CONFIG=../config/prod.yml

BACKEND_APP_DIR=../../apps/backend   # Path to the backend app directory

# Using yq to extract values from the YAML file
AWS_REGION=$(yq e '.aws_region_name' $SHARED_CONFIG)
AWS_ACCOUNT_ID=$(yq e '.aws_account_id' $SHARED_CONFIG)
AWS_PROFILE=$(yq e '.aws_profile_name' $SHARED_CONFIG)
SSM_DOCKER_HUB_USERNAME_KEY=$(yq e '.ssm_params.codebuild_docker_hub_username' $SHARED_CONFIG)
SSM_DOCKER_HUB_PASSWORD_KEY=$(yq e '.ssm_params.codebuild_docker_hub_password' $SHARED_CONFIG)
SSM_CODESTAR_CONNECTION_ARN_KEY=$(yq e '.ssm_params.codepipeline_codestarconnection_arn' $SHARED_CONFIG)

BACKEND_ECR_REPOSITORY_NAME=$(yq e '.cicd.ecr_backend_repository_name' $SHARED_CONFIG)

# Construct the ECR repository URLs dynamically
BACKEND_ECR_REPOSITORY_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${BACKEND_ECR_REPOSITORY_NAME}"
####################################################################################
############## Terraform State
####################################################################################
# !!!!!!!!!!!! Important
# Make sure first terraform state backend resources are setup properly (s3 bucket and dynamodb table)


####################################################################################
############## Set up SSM parameters
####################################################################################
# Function to check if environment variable exists or prompt for input
set_ssm_param_from_env_or_input() {
    local param_key=$1
    local env_var_name=$2
    local profile=$3
    local region=$4

    # Get the value of the environment variable
    local param_value=${env_var_name}

    if [ -z "$param_value" ]; then
        # If the environment variable is not set, prompt for user input
        read -p "Enter value for $param_key: " param_value
    fi

    # Set the parameter in SSM Parameter Store
    aws ssm put-parameter --name "$param_key" --value "$param_value" --profile "$profile" --region "$region" --type String --overwrite > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Successfully set SSM parameter: $param_key with value: $param_value"
    else
        echo "Failed to set SSM parameter: $param_key"
        return 1
    fi
}

# Use the environment variable if set, otherwise ask the user
# set_ssm_param_from_env_or_input "$SSM_DOCKER_HUB_USERNAME_KEY" "$DOCKER_HUB_USERNAME" "$AWS_PROFILE" "$AWS_REGION"
# set_ssm_param_from_env_or_input "$SSM_DOCKER_HUB_PASSWORD_KEY" "$DOCKER_HUB_PASSWORD" "$AWS_PROFILE" "$AWS_REGION"
# set_ssm_param_from_env_or_input "$SSM_CODESTAR_CONNECTION_ARN_KEY" "$CODESTAR_CONNECTION_ARN" "$AWS_PROFILE" "$AWS_REGION"



####################################################################################
############## Create ECR Repositories
####################################################################################
./tf.sh apply-auto-approve shared ecr_repositories

####################################################################################
############## Push first default images of backend 
####################################################################################

# Function to login to ECR
ecr_login() {
  echo "Logging into Amazon ECR with profile $AWS_PROFILE..."
  aws ecr get-login-password --region $AWS_REGION --profile $AWS_PROFILE | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
  if [ $? -ne 0 ]; then
    echo "ECR login failed"
    exit 1
  fi
  echo "ECR login successful."
}

# Function to build and push a Docker image
build_and_push_image() {
  local app_dir=$1
  local ecr_repository_url=$2
  local build_args=${3:-""}  # Optional build arguments

  local image_tag="latest"
  echo $app_dir
  echo $ecr_repository_url

  echo "Building Docker image in $app_dir..."
  cd $app_dir
  docker build $build_args -t $ecr_repository_url:$image_tag .
  echo "Pushing Docker image to ECR..."
  docker push $ecr_repository_url:$image_tag
  if [ $? -ne 0 ]; then
    echo "Failed to push Docker image"
    exit 1
  fi
  echo "Docker image pushed to ECR successfully."
}

# Main script logic
ecr_login

# Build and push backend 
build_and_push_image $BACKEND_APP_DIR $BACKEND_ECR_REPOSITORY_URL

echo "Build and push process completed for both dev and prod environments."


