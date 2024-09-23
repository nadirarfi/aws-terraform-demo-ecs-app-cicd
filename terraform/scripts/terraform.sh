#!/bin/bash

terraform_setup_backend() {
    local resource_path="$1"
    local config_file="$2"

    config_folder_name="config"
    config_file_name="shared.yml"
    relative_path_to_config_folder=$(find_relative_path_to_config_folder "$resource_path" "$config_folder_name")
    config_file="$relative_path_to_config_folder/$config_file_name"

    # Navigate to the resource directory
    cd "$resource_path" || {
        echo -e "\033[1;31mFailed to navigate to $resource_path\033[0m"
        exit 1
    }

    # Read YAML config file using yq
    S3_BUCKET=$(yq e ".aws_tf_state_s3_bucket_name" $config_file)
    DYNAMODB_TABLE=$(yq e ".aws_tf_state_dynamodb_table_name" $config_file)
    REGION=$(yq e ".aws_region_name" $config_file)
    PROFILE=$(yq e ".aws_profile_name" $config_file)
    KEY_PREFIX="$resource_path/terraform.tfstate"

    # Define the path for the backend configuration file
    BACKEND_FILE="backend.tf"
    [ -f "$BACKEND_FILE" ] && rm "$BACKEND_FILE" 

    # Generate backend.tf configuration dynamically
    cat <<EOL > $BACKEND_FILE
terraform {
    backend "s3" {
        profile        = "$PROFILE"
        bucket         = "$S3_BUCKET"
        key            = "$KEY_PREFIX"
        region         = "$REGION"
        dynamodb_table = "$DYNAMODB_TABLE"
        encrypt        = true
    }
}
EOL

}

terraform_init() {
    terraform fmt -recursive
    terraform init -migrate-state ||
        {
            echo -e "\033[1;31mTerraform init failed\033[0m"
            exit 1
        }
}

# Function to run terraform plan
terraform_plan() {
    echo "Running 'terraform plan' to preview the changes that will be applied..."
    terraform plan || {
        echo -e "\033[1;31mTerraform plan failed\033[0m"
        exit 1
    }
}

# Function to run terraform apply
terraform_apply() {
    local plan_output="tfplan.out"
    echo "Running 'terraform plan' and saving the output to $plan_output..."
    terraform plan -out=$plan_output || {
        echo -e "\033[1;31mTerraform plan failed\033[0m"
        exit 1
    }

    echo "Applying the saved plan with 'terraform apply $plan_output'..."
    terraform apply "$plan_output" || {
        echo -e "\033[1;31mTerraform apply failed\033[0m"
        exit 1
    }
    rm $plan_output
    rm -rf .terraform
    rm .terraform.lock.hcl
}

terraform_apply_auto_approve() {
    local plan_output="tfplan.out"
    echo "Running 'terraform plan' and saving the output to $plan_output..."
    terraform plan -out=$plan_output || {
        echo -e "\033[1;31mTerraform plan failed\033[0m"
        exit 1
    }

    echo "Applying the saved plan with 'terraform apply $plan_output'..."
    terraform apply --auto-approve "$plan_output" || {
        echo -e "\033[1;31mTerraform apply failed\033[0m"
        exit 1
    }
    rm $plan_output
    rm -rf .terraform
    rm .terraform.lock.hcl    
}

# Function to run terraform destroy
terraform_destroy() {
    echo "Running 'terraform destroy' to destroy the resource..."
    terraform destroy || {
        echo -e "\033[1;31mTerraform destroy failed\033[0m"
        exit 1
    }
}

terraform_destroy_auto_approve(){
    echo "Running 'terraform destroy auto approve' to destroy the resource..."
    terraform destroy --auto-approve || {
        echo -e "\033[1;31mTerraform destroy failed\033[0m"
        exit 1
    }    
}