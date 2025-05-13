#!/bin/bash
# Determine which package provides a virtual package

apt-cache showpkg $1 | awk '/Pa/, /Reverse P/ {next} {print $1 | "sort"}' | uniq;
# OR
echo "OR"
apt-cache search "^${1}$" | awk '{print $1}'
