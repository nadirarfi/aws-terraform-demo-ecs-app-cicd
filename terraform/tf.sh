#!/bin/bash

# Import bash scripts
. ./scripts/helpers.sh
. ./scripts/terraform.sh


# Main script logic
if [ $# -ne 3 ]; then
    echo "Usage: $0 <action> <env> <resource>"
    exit 1
fi

action="$1"
env="$2"
resource="$3"

# Determine the full resource path
resource_path=$(get_resource_path "$env" "$resource")
terraform_setup_backend "$resource_path" "$config_file"
terraform_init 

# Execute the specified action
case $action in
"plan") terraform_plan ;;
"apply") terraform_apply ;;
"apply-auto-approve") terraform_apply_auto_approve ;;
"destroy") terraform_destroy ;;
"destroy-auto-approve") terraform_destroy_auto_approve ;;

*)
    echo -e "\033[1;31mInvalid action. Valid actions are: plan, apply, destroy.\033[0m"
    exit 1
    ;;
esac

echo -e "\033[1;32mAction $action completed successfully.\033[0m"
