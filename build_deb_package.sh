#!/bin/bash -e
# Build a .deb package.
# Files to be included in the package should be in a directory
# with the same name as the package to build

# Build parameters:
pkgname=
description=
version=
arch=amd64
pkgversion=1
depends=
conflicts=
replaces=
breaks=
run_ldconfig=true

# Build package
deb_name="${pkgname}_${version}-${pkgversion}_${arch}"
deb_dir="$deb_name"
mkdir "${deb_dir}" || exit 1
cp -r $pkgname/* "${deb_dir}" || (echo "Failed to copy files"; exit 1)
mkdir "$deb_dir/DEBIAN/"
cat << EOF > "$deb_dir/DEBIAN/control"
Package: $pkgname
Version: $version-$pkgversion
Section: GSS
Priority: optional
Architecture: $arch
Depends: $depends
Breaks: $breaks
Replaces: $replaces
Conflicts: $conflicts
Maintainer: Greensea Systems <support@greensea.com>
Description: $description
EOF

# Trigger ldconfig if necessary
if [[ "$run_ldconfig" == "true" ]]
then
cat << EOF > "$deb_dir/DEBIAN/triggers"
activate-noawait ldconfig
EOF
fi

fakeroot dpkg-deb --build "$deb_dir"
