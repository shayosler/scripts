#!/bin/bash
#Run as root/sudo
reqs="foo-dev,bar\|baz"
pkgname="name"
version="0.1"
./configure
make -j4
checkinstall --nodoc \
             --fstrans=yes \
             --pkgname=$pkgname \
             --pkggroup=GSS \
             --pkgversion=$version \
             --provides=$pkgname \
             --requires="$reqs" \
             --backup=no \
             -y \
             --install=no \
             make install
