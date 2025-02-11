#!/bin/bash

declare -a files
directory="university_db"
files=("create_and_use_db.sql" "drop_db.sql") # Array of filenames

# Check if sqlfluff is installed.  If not, provide instructions.
if ! command -v sqlfluff &> /dev/null; then
  echo "Error: sqlfluff is not installed. Please install it (e.g., 'pip install sqlfluff')."
  exit 1
if

for file in "${files[@]}"; do
  filepath="$directory/$file"
  if [ ! -f "$filepath" ]; then
    echo "Error: $filepath does not exist."
    exit 1  # Skip to the next file
  if

  echo "Checking syntax for $filepath..."

  # Run sqlfluff and capture the output and exit code
  output=$(sqlfluff lint "$filepath" --dialect mysql 2>&1) # Capture stderr too
  exit_code=$?

  if [ "$exit_code" -eq 0 ]; then
    echo "$filepath: Syntax OK"
  else
    echo "Error: Syntax errors found in $filepath:"
    echo "$output"  # Print the sqlfluff output
    # Optional: Exit with an error if you want the script to stop on errors:
    exit 1
  if
done

exit 0 # Script finished successfully