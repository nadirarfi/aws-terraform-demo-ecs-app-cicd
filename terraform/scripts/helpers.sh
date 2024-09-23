#!/bin/bash

get_resource_path() {
    local env="$1"
    local resource="$2"
    local RESOURCES_DIRECTORY="live"
    resource_path=""
    if [ -d "$RESOURCES_DIRECTORY/$env" ]; then
        # Loop through each top-level layer (e.g., apps, infrastructure, etc.)
        for layer in $(find "$RESOURCES_DIRECTORY/$env" -mindepth 1 -maxdepth 1 -type d); do
            # echo "Checking layer: $layer"
            # Loop through each sublayer (e.g., ecs_service, vpc, etc.)
            for sublayer in $(find "$layer" -mindepth 1 -maxdepth 1 -type d); do
                # echo "Checking sublayer: $sublayer"
                # Check if the resource exists in this sublayer
                if [ "$(basename "$sublayer")" == "$resource" ]; then
                    resource_path="$sublayer"
                    break 2
                fi
            done
        done
    fi

    if [ -z "$resource_path" ]; then
        echo -e "\033[1;31mResource $resource not found in environment $env.\033[0m"
        exit 1
    fi
    echo $resource_path
}

find_relative_path_to_config_folder() {
    local start_dir="$1"
    local config_folder="$2"
    local project_root="terraform"
    find_relative_path_to_config_folder=""

    while [ "$start_dir" != "/" ]; do
        # Check if the config folder exists in the current directory
        if [ -d "$start_dir/$config_folder" ]; then
            # Calculate the relative path from the original start directory to the found config folder
            relative_path_to_config_folder=$(realpath --relative-to="$1" "$start_dir/$config_folder")
            echo "$relative_path_to_config_folder"
            return 0
        fi

        # Stop if we've reached the project root directory
        if [ "$(basename "$start_dir")" = "$project_root" ]; then
            break
        fi

        # Move up one directory level
        start_dir=$(dirname "$start_dir")
    done

    echo "Error: $config_folder folder not found."
    return 1
}

# Function to display clear and prominent prompts with larger text and green color
prompt() {
    echo -e "\033[1;32m\033[1m$1\033[0m" # Bright green color and bold text
}

# Function to confirm the action with the user
confirm_action() {
    read -p "Are you sure you want to proceed with $1? Type 'yes' to confirm: " confirm
    if [[ "$confirm" != "yes" ]]; then
        echo -e "\033[1;33mAction aborted.\033[0m" # Yellow color for warning
        exit 1
    fi
}

# Function to confirm destruction with additional warning in red
confirm_destroy() {
    echo -e "\033[1;31mWARNING: You are about to destroy the resource!\033[0m" # Red color for warning
    read -p "Type 'yes' to confirm the destruction: " confirm
    if [[ "$confirm" != "yes" ]]; then
        echo -e "\033[1;33mDestroy action aborted.\033[0m" # Yellow color for warning
        exit 1
    fi
}

# Function to handle the user's selection
handle_selection() {
    local prompt_message="$1"
    local options="$2"
    local preview_command="$3"

    local selection=$(echo -e "$options" | fzf --height 50% --layout=reverse --border --ansi --prompt="$prompt_message > " --preview="$preview_command" --preview-window=right:50%)

    if [[ "$selection" == "Go Back" ]]; then
        return 1
    fi

    echo "$selection"
}

colorize_options() {
    local items=("$@")
    local colored_items=()
    local regular_color="\033[1;34m" # Blue color for regular options
    local go_back_color="\033[1;31m" # Red color for "Go Back"

    for item in "${items[@]}"; do
        if [[ "$item" == "Go Back" ]]; then
            colored_items+=("${go_back_color}${item}\033[0m")
        else
            colored_items+=("${regular_color}${item}\033[0m")
        fi
    done

    printf "%s\n" "${colored_items[@]}"
}
