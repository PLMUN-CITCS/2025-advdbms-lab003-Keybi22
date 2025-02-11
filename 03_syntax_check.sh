#!/bin/bash

declare -a files
directory="university_db"
files=("create_and_use_db.sql" "drop_db.sql") # Array of filenames

# Check if sqlfluff is installed. If not, provide instructions.
if ! command -v sqlfluff &> /dev/null; then
  echo "Error: sqlfluff is not installed. Please install it (e.g., 'pip install sqlfluff')."
  exit 1
fi

for file in "${files[@]}"; do
  filepath="$directory/$file"
  if [ ! -f "$filepath" ]; then
    echo "Warning: $filepath does not exist. Skipping file."
    continue  # Skip to the next file
  fi

  echo "Checking syntax for $filepath..."

  # Run sqlfluff and capture the output and exit code
  output=$(sqlfluff lint "$filepath" --dialect mysql 2>&1) # Capture stderr too
  exit_code=$?

  if [ "$exit_code" -eq 0 ]; then
    echo "$filepath: Syntax OK"
  else
    echo "$filepath: Syntax error(s) found:"
    echo "$output"  # Print the sqlfluff output
    # Exit with an error if you want the script to stop on errors:
    exit 1
  fi
done

exit 0 # Script finished successfully
