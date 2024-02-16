#!/usr/bin/env bash
# read stdin and print it to stdout
stdin=$(cat)
if [[ "$stdin" == "" ]]; then
    echo "stdin is empty"
else
    echo "stdin: $stdin"
fi
