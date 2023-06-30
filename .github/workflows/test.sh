#!/bin/bash

Diff=$(git diff --name-only HEAD^ HEAD)
Pattern=".tex"
# We can change the pattern easily

echo $Diff

for arg in "$Diff"; do
    echo $arg
    if echo "$arg" | grep -q "$Pattern"; then
        echo "$arg"
        pdflatex $arg
    fi
done