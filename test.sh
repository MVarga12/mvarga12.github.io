#!/bin/bash

file=$1

while IFS= read -r line
do
    if [[ $line =~ file ]] #; then printf '%s\n' "$line"; fi
    then
        read line
        if [[ $line =~ comment ]]; then echo $line 
        else echo "file = {" + $line
        fi
    fi
done < "$file"
