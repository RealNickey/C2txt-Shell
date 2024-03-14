#!/usr/bin/bash
# Set the input and output directories
input_dir="G:\\new"
output_dir="G:\\new"
nas_dir="//NAS_URL/print"
username="USERNAME"
password="PASSWORD"
domain="DOMAIN"

# Loop through all .c files in the input directory
for file in ${input_dir}/*.c; do
    # Compile the C program
    program_name="${file%.c}"
    if gcc -o "$program_name" "$file"; then
        # Capture program output with user interaction
        output=$(script -q /dev/null ./"$program_name")

        # Remove the initial script header and trailing exit message
        output="${output#*Script started on}"
        output="${output%script finished, exit status 0}"

        # Get the current date
        Current_date=$(date +"%D")

        # Create a new .txt file with your name, class, C code, inputs, and program output
        txt_file="${file%.c}.txt"
        echo "/*" > "$txt_file"
        echo "Name: Aswin Jim Thuruthippilly" >> "$txt_file"
        echo "Class: S2 CG" >> "$txt_file"
        echo "Roll NO: 16" >> "$txt_file"
        echo "Date: $Current_date" >> "$txt_file"
        echo "Name of Program: ${file%.c}" >> "$txt_file"
        echo "*/" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "" >> "$txt_file"
        cat "$file" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "/* Inputs: $(cat input.txt) */" >> "$txt_file"
        echo "" >> "$txt_file"
        echo "/* Output: $output */" >> "$txt_file"

        # Move the text file to the output directory
        mv "$txt_file" "$output_dir"

        # Copy the text file to the NAS storage
        smbclient "$nas_dir" -U "$username"%"$password" -W "$domain" -c "put $output_dir/$txt_file"
    fi
done
