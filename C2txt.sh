#!/usr/bin/bash
# Set the input and output directories
input_dir="input_folder"
output_dir="output_folder"

# Loop through all .c files in the input directory
for file in ${input_dir}/*.c; do
    # Generate random inputs
    input=$(shuf -i 1-100 -n 3 | tr '\n' ' ')

    # Compile the C program and save the output to a variable
    output=$(gcc -o "${file%.c}" "$file" && echo "$input" | ./"${file%.c}")

    # Create a new .txt file with your name, class, C code, inputs, and program output
    txt_file="${file%.c}.txt"
    echo "/*" > "$txt_file"
    echo "Name:Aswin Jim Thuruthippilly" >> "$txt_file"
    echo "Class: S2 CG" >> "$txt_file"
    echo "Roll NO:16" >> "$txt_file"
    echo "Name of Program:" >> "$txt_file"
    echo "*/" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "" >> "$txt_file"
    cat "$file" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "/* Inputs: ${input} */" >> "$txt_file"
    echo "" >> "$txt_file"
    echo "/* Output: ${output} */" >> "$txt_file"

    # Move the text file to the output directory
    mv "$txt_file" "$output_dir"
done