#!/bin/bash 
# Download a package and all of it's dependencies with some excluded
package=$1
shift
excludes=("$@")
# deps=$(apt-rdepends $package | grep -v "^ ")
deps=$(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances "$package" | grep "^\w" | sort -u)
for p in "${excludes[@]}"
do
    deps=$(grep -v "$p" <<< "$deps")
done

apt download $deps

