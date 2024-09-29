#!/bin/bash

# Import bash scripts
source ./helpers/functions.sh
source ./helpers/tf_actions.sh

cd ../ # Ensure we are at the terraform directory

# Execute actions
execute_actions() {
    terraform_setup_backend "$resource_path" "$config_file"
    terraform_init
    # Execute the selected action
    prompt "Executing $action"
    case $action in
    "plan") terraform_plan ;;
    "apply") terraform_apply ;;
    "destroy") terraform_destroy ;;
    esac
    echo -e "\033[1;32mAction $action completed successfully.\033[0m" # Green color for success
}

#################################### Main
#!/bin/bash

# Ensure the necessary functions and variables are loaded

if [[ $# -eq 2 ]]; then
    env="$1"
    resource="$2"

    # Determine the full resource path
    resource_path=$(get_resource_path "$env" "$resource")

    # Automatically jump to the action selection
    prompt "Direct Mode: Select an Action to Perform"
    action=$(handle_selection "Action" "$(colorize_options "plan" "apply" "destroy" "Go Back")" "echo 'plan: Run terraform plan\napply: Run terraform apply after plan\ndestroy: Run terraform destroy'")

    if [[ $? -eq 1 ]]; then
        exit 1
    fi

    execute_actions

else
    while true; do
        # Step 1: Select an Environment
        prompt "STEP 1: Select an Environment"
        echo "Please select the environment (e.g., dev, prod) you want to work with."
        env=$(handle_selection "Environment" "$(colorize_options $(ls live | grep -v -i 'README') "Go Back")" "")

        if [[ $? -eq 1 ]]; then
            break
        fi

        # Step 2: Select Layer in Environment
        while true; do
            prompt "STEP 2: Select a Layer in the $env Environment"
            echo "Now, select the specific layer (e.g., apps, infrastructure) in the $env environment."
            layer=$(handle_selection "Layer" "$(colorize_options $(ls live/$env | grep -v -i 'README') "Go Back")" "")

            if [[ $? -eq 1 ]]; then
                continue 2
            fi

            # Step 3: Select Resource in Layer
            prompt "STEP 3: Select a Resource in the $layer Layer"
            echo "Select the specific resource in the $layer layer that you want to manage."
            resource=$(handle_selection "Resource" "$(colorize_options $(ls live/$env/$layer | grep -v -i 'README') "Go Back")" "")

            if [[ $? -eq 1 ]]; then
                continue 2
            fi

            resource_path="live/$env/$layer/$resource"
            break 3
        done
    done
fi

# Ensure a resource is selected
if [[ -z "$resource_path" ]]; then
    echo -e "\033[1;31mNo resource selected. Exiting.\033[0m" # Red color for error
    exit 1
fi

# Step 4: Select Action
prompt "STEP 4: Select an Action to Perform"
echo "Now that you've selected the resource at $resource_path, choose an action to perform."
action=$(handle_selection "Action" "$(colorize_options "plan" "apply" "destroy" "Go Back")" "echo 'plan: Run terraform plan\napply: Run terraform apply after plan\ndestroy: Run terraform destroy'")
if [[ $? -eq 1 ]]; then
    exit 1
fi

# Step 5: Execute the Selected Action
prompt "STEP 5: Executing $action"
execute_actions
