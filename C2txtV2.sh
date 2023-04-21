#!/bin/bash

# Define input and output folders
input_folder="input"
output_folder="output"

# Create output folder if it doesn't exist
mkdir -p "$output_folder"

# Loop through all C programs in the current directory
for c_program in *.c; do
    # Get the program name without the extension
    program_name="${c_program%.c}"

    # Generate random input if no input file exists
    if [ ! -f "$input_folder/$program_name.in" ]; then
        inputs="$((1 + RANDOM % 100))"
    else
        # Otherwise, read inputs from input file
        inputs="$(cat "$input_folder/$program_name.in")"
    fi

    # Compile C program
    gcc "$c_program" -o "$program_name"

    # Run C program with inputs and capture output
    output="$(./"$program_name" <<< "$inputs" 2>&1)"

    # Remove compiled program
    rm "$program_name"

    # Create documentation file with name, class, C code, and output
    doc_file="$output_folder/$program_name.txt"
    echo "Name: Your Name
Class: Your Class
Date: $(date +%D)

C Code:

$(cat "$c_program")


Inputs: $inputs


Output:

$output" > "$doc_file"

    # Move documentation file to output folder
    mv "$doc_file" "$output_folder"
done
