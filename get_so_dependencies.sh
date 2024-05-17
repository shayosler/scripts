#!/bin/bash
app=$1

# Get list of shared libraries this application depends on
libs=($(ldd "$app" | awk '{print $1}'))

# Get the packages that provide those libraries
packages=()
for lib in ${libs[@]}
do
    package=$(dpkg -S "$lib" | sed -r -n -e 's/(.*):.*/\1/p')
    echo "Package for $lib: '$package'"
    packages+="$package"
done

# Get unique list of packages
uniq_packages=($(echo "${packages[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo "Packages: ${uniq_packages[@]}"
