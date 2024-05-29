#!/bin/bash

# Check if at least one file path is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <file_path1> <file_path2> ..."
  exit 1
fi

# Function to replace environment variables in a file
replace_env_vars() {
  local FILE_PATH=$1

  # Check if file exists
  if [ ! -f "$FILE_PATH" ]; then
    echo "File not found: $FILE_PATH"
    return
  fi

  # Read the file line by line
  while IFS= read -r line; do
    # Use a regex to find placeholders in the format ${VAR_NAME}
    while [[ $line =~ (\$\{([A-Z_]+)\}) ]]; do
      var=${BASH_REMATCH[1]}
      var_name=${BASH_REMATCH[2]}
      var_value=${!var_name}

      if [ -n "$var_value" ]; then
        # Replace the placeholder with the actual value
        line=${line//${var}/$var_value}
      else
        echo "Warning: No value found for variable $var_name in file $FILE_PATH"
        break
      fi
    done
    echo "$line"
  done < "$FILE_PATH" > "${FILE_PATH}.tmp"

  # Replace the original file with the updated file
  mv "${FILE_PATH}.tmp" "$FILE_PATH"

  echo "Environment variables replaced successfully in $FILE_PATH"
}

# Loop over each file path provided as an argument
for FILE_PATH in "$@"; do
  replace_env_vars "$FILE_PATH"
done

