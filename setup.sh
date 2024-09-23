#!/bin/bash

####################################################################################
############## Configuration
####################################################################################
# Change directory
cd terraform

# Load environment-specific variables from shared.yml
SHARED_CONFIG=./config/shared.yml
DEV_CONFIG=./config/dev.yml
PROD_CONFIG=./config/prod.yml

BACKEND_APP_DIR=../apps/backend   # Path to the backend app directory

# Using yq to extract values from the YAML file
DEV_APP_BACKEND_DOMAIN_NAME=$(yq e '.app_backend_domain_name' $DEV_CONFIG)
PROD_APP_BACKEND_DOMAIN_NAME=$(yq e '.app_backend_domain_name' $PROD_CONFIG)
AWS_REGION=$(yq e '.aws_region_name' $SHARED_CONFIG)
AWS_ACCOUNT_ID=$(yq e '.aws_account_id' $SHARED_CONFIG)
AWS_PROFILE=$(yq e '.aws_profile_name' $SHARED_CONFIG)

BACKEND_ECR_REPOSITORY_NAME=$(yq e '.cicd.ecr_backend_repository_name' $SHARED_CONFIG)

# Construct the ECR repository URLs dynamically
BACKEND_ECR_REPOSITORY_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${BACKEND_ECR_REPOSITORY_NAME}"
####################################################################################
############## Terraform State
####################################################################################
# !!!!!!!!!!!! Important
# Make sure first terraform state backend resources are setup properly (s3 bucket and dynamodb table)



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
  local env=$2
  local ecr_repository_url=$3
  local build_args=${4:-""}  # Optional build arguments

  local image_tag="$env-latest"
  echo $app_dir
  echo $env
  echo $ecr_repository_url

  echo "Building Docker image for $env environment in $app_dir..."
  cd $app_dir
  docker build $build_args -t $ecr_repository_url:$image_tag .
  if [ $? -ne 0 ]; then
    echo "Docker build failed for $env"
    exit 1
  fi
  echo "Docker image for $env built successfully."

  echo "Pushing Docker image for $env environment to ECR..."
  docker push $ecr_repository_url:$image_tag
  if [ $? -ne 0 ]; then
    echo "Failed to push Docker image for $env"
    exit 1
  fi
  echo "Docker image for $env pushed to ECR successfully."
}

# Main script logic
ecr_login

#################################### Steps for dev environment
echo "Processing dev environment..."
# Build and push backend for dev
build_and_push_image $BACKEND_APP_DIR "dev" $BACKEND_ECR_REPOSITORY_URL

#################################### Steps for prod environment
# echo "Processing prod environment..."
# # Build and push backend for prod
# build_and_push_image $BACKEND_APP_DIR "prod" $BACKEND_ECR_REPOSITORY_URL

echo "Build and push process completed for both dev and prod environments."
