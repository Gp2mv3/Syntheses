#!/bin/bash


# Input string
input="path/to/location/file.tex"
pattern=".tex"

# Set the IFS to "/"
IFS="/"

# Read the input string into an array
read -ra parts <<< "$input"

# Restore the default IFS
IFS=" "

# Print the array elements
for part in "${parts[@]}"; do
  ls
done

test="1 2 3 4"
Done=false

for arg in $test; do
    echo $arg
    if [ $arg == 3 ]; then
        echo "Three"
        Done=true
    fi
    if $Done; then 
        echo "Already found my three"
    fi 
done