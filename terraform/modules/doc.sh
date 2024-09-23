#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $SCRIPT_DIR

# Set the base directory where the Terraform modules are located relative to the script
MODULES_DIR="${SCRIPT_DIR}"

# Set the base directory where the examples will be saved
EXAMPLES_DIR="${MODULES_DIR}/examples"

MODULE_SOURCE_RELATIVE_PATH="../../../../.."

# Set the output file name for the documentation
OUTPUT_FILE="README.md"

# Docker image for terraform-docs
DOCKER_IMAGE="quay.io/terraform-docs/terraform-docs:0.18.0"

# Function to check if a Docker image exists locally
image_exists() {
    docker image inspect $1 > /dev/null 2>&1
}

# Check if the terraform-docs Docker image exists locally
if image_exists ${DOCKER_IMAGE}; then
    echo "Using existing Docker image: ${DOCKER_IMAGE}"
else
    echo "Pulling Docker image: ${DOCKER_IMAGE}"
    docker pull ${DOCKER_IMAGE}
fi

# Function to generate documentation for a single module
generate_docs() {
    local module_dir=$1
    local module_name=$(basename "$module_dir")

    # Run the docker container and ensure it is removed after execution with --rm flag
    docker run --rm --volume "${module_dir}:/terraform-docs" -u $(id -u) ${DOCKER_IMAGE} markdown /terraform-docs > "${module_dir}/${OUTPUT_FILE}"

    if [ $? -eq 0 ]; then
        # Print in pink color
        echo -e "\033[95m   - $module_name\033[0m"
    else
        echo "Failed to generate docs for $module_name"
        exit 1
    fi
}

echo -e "\033[95mTerraform module documentation generated for:\033[0m"

# Recursively find directories that contain a main.tf file
find "${MODULES_DIR}" -type f -name "main.tf" | while read -r tf_file; do
    # Extract the directory containing the main.tf file
    module_dir=$(dirname "$tf_file")
    # Generate documentation for this module
    generate_docs "$module_dir"
done

# Additional cleanup step (if necessary)
docker container prune -f > /dev/null 2>&1

# Function to create an example usage of the module
generate_module_usage() {
    local module_path="$1"
    local example_folder="$2"
    local module_name="$3"
    
    # Create the example folder if it doesn't exist
    mkdir -p "$example_folder"

    # Generate the example filename based on the module path
    module_name_formatted=$(echo "$module_name" | tr '/' '_')
    example_file="$example_folder/${module_name_formatted}.tf"

    # Calculate the relative path for the module source
    relative_path=$(echo "$module_path" | sed "s|$MODULES_DIR||")
    source_path="$MODULE_SOURCE_RELATIVE_PATH/modules${relative_path}"

    echo "# ========== \"$module_name_formatted\" ==========" >> "$example_file"
    echo "module \"$module_name_formatted\" {" >> "$example_file"
    echo "  source = \"$source_path\"" >> "$example_file"
    echo "" >> "$example_file"

    # Read variables from variables.tf and include default values or examples if defined
    if [ -f "$module_path/variables.tf" ]; then
        awk '
            BEGIN { inside_variable = 0; var_name = ""; var_type = ""; default_value = ""; }
            /^variable/ { inside_variable = 1; var_name = $2; gsub(/"/, "", var_name); var_type = ""; default_value = ""; }
            /^type/ { var_type = $0; gsub(/^[[:space:]]*type[[:space:]]*=[[:space:]]*/, ""); }
            /default/ { sub(/^[[:space:]]+default[[:space:]]*=[[:space:]]*/, ""); default_value = $0; }
            /^}/ { 
                if (inside_variable) { 
                    if (var_type ~ /list\(object\(/) {
                        if (default_value == "[]") 
                            printf "  %s = [\n    {\n      from_port       = 0\n      to_port         = 0\n      protocol        = \"\"\n      cidr_blocks     = [\"\"]\n      security_groups = [\"\"]\n    }\n  ]\n", var_name;
                        else
                            printf "  %s = %s\n", var_name, default_value; 
                    } else if (var_type ~ /list\(/) {
                        if (default_value == "[]")
                            printf "  %s = [\"\"]\n", var_name;
                        else
                            printf "  %s = %s\n", var_name, default_value; 
                    } else if (var_type ~ /map\(/) {
                        if (default_value == "{}")
                            printf "  %s = {}\n", var_name;
                        else
                            printf "  %s = %s\n", var_name, default_value; 
                    } else if (default_value == "") 
                        printf "  %s = \"\"\n", var_name; 
                    else 
                        printf "  %s = %s\n", var_name, default_value; 
                }
                inside_variable = 0; 
            }
        ' "$module_path/variables.tf" >> "$example_file"
    else
        echo "  # No variables.tf file found in $module_path" >> "$example_file"
    fi

    echo "}" >> "$example_file"

    echo "Example usage created in $example_file"
}

# Clean up the existing examples before generating new ones
# echo "Cleaning up existing examples..."
# echo $EXAMPLES_DIR
rm -rf "$EXAMPLES_DIR"

# Iterate through all modules in the MODULES_DIR
find "$MODULES_DIR" -type f -name "main.tf" | while read -r main_tf_path; do
    # Extract the module directory relative to the MODULES_DIR
    module_dir=$(dirname "$main_tf_path")
    module_name=$(echo "$module_dir" | sed "s|$MODULES_DIR/||")

    # Generate the example usage
    generate_module_usage "$module_dir" "$EXAMPLES_DIR" "$module_name"
done
