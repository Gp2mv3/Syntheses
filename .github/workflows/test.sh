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
  if echo "$part" | grep -q "$pattern"; then
    # Print the matched argument
    pdflatex "$part"
  fi
  cd "$part"
  ls
done