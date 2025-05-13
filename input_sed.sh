#!/bin/bash
output=$1
error=$2
info=$3
input=$(</dev/stdin)
echo "INPUT: "
echo "$input"
read -rp "sed script: " script </dev/tty
echo "Running: sed -r -e $script" > "$info"
echo "$input" | sed -r -e "$script" 1>"$output" 2>"$error"
