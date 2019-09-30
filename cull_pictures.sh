#!/bin/bash -x

if [[ ! -d "$1" ]]
then
    echo "First argument must be a directory"
    exit 1
fi

# first argument should be dir
dir=$(basename "$1")
del_dir="/home/shay/Pictures/to_delete/$dir"
mkdir -p "$del_dir"
/home/shay/development/scripts/diff_pictures.py "$1" | xargs -d "\n" -I{} mv {} "$del_dir"

