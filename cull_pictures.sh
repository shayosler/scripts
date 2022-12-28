#!/bin/bash -x

if [[ ! -d "$1" ]]
then
    echo "First argument must be a directory"
    exit 1
fi

# First argument should be dir
album_dir=$(basename "$1")

# Find pictures to "delete"
to_del_dir="/home/shay/Pictures/to_delete"
del_dir="$to_del_dir/$album_dir"
mkdir -p "$del_dir"
/home/shay/development/scripts/diff_pictures.py "$1" | xargs -d "\n" -I{} mv {} "$del_dir"

# Archive
tar -C "$to_del_dir" -cvzf "$to_del_dir/${album_dir}.tar.gz" "$album_dir" --force-local
