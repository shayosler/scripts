#!/bin/bash

# Name of output run is first argument
output_dir="$1"
shift
if [[ -e  "$output_dir" ]]
then
    echo "Error: $output_dir already exists"
    exit 1
elif [[ -e "${output_dir}.run" ]]
then
    echo "Error: ${output_dir}.run already exists"
    exit 1
fi

# Create directory to hold runs, start install script
mkdir "$output_dir"
install_script="$output_dir"/install.sh
touch "$install_script"
chmod 755 "$install_script"
echo '#!/bin/bash' > "$install_script"

# All subsequent args are .runs to bundle, in order
description="Installer for "
while test $# -gt 0
do
    run_path=$1
    cp "$run_path" "$output_dir"
    run=$(basename "$run_path")
    echo "./$run || { echo \"Failed to install $run\"; exit 1; }" >> "$install_script"
    description="$description $run"
    shift
    if [[ -n "$1" ]]
    then
        description="${description},"
    fi
done

create_run.sh "$output_dir" "$description"
