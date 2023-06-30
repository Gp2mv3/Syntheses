#!/bin/bash

# List of arguments
arguments="doc1.pdf doc2.tex doc3.png"

# Pattern to match
pattern=".tex"

# Loop through each argument
for arg in $arguments; do
  # Use grep to check if the argument matches the pattern
  if echo "$arg" | grep -q "$pattern"; then
    # Print the matched argument
    echo "$arg"
  fi
done
