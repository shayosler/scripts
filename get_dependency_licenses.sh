#!/bin/bash
# Try to find licenses for 3rd party libraries a binary uses
# Queries dpkg to figure out which .deb package each
# shared object that a binary links against is from, then
# looks for a `copyright` file in that package

####################################################
# Params
binaries=()
outdir=./LICENSES

####################################################
# Arguments
while test $# -gt 0
do
  case "$1" in
    -o|--output_dir)
      out_dir="$2"
      shift
      ;;
    
    -b|--binary)
      binaries+=("$2")
      shift
      ;;
      
    #Catch all other arguments passed as --<arg> here
    --*)
      echo "Unknown option $1"
      exit 1
      ;;
    #Catch all other args here
    *)
      echo "Unknown option $1"
      exit 1
       ;;
  esac
  shift
done

############################################
# Get a list of libraries each binary links against
shared_objects=()
for binary in "${binaries[@]}"
do
  mapfile -t sos < <( ldd "$binary" | awk '{print $3}' )
  shared_objects=( "${shared_objects[@]}" "${sos[@]}" )
done

# Get unique list of libraries
IFS=" " read -r -a shared_objects <<< "$(echo "${shared_objects[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"

############################################
# Get a list of packages associated with each library
unidentified_libs=()
packages=()
for lib in "${shared_objects[@]}"
do
  if [[ "$lib" != "/"* ]]
  then
    echo "Skipping '$lib'"
    continue
  fi
  package=$(dpkg -S "$lib" | awk -F: '{print $1}')
  if [[ -z "$package" ]]
  then
    echo "Failed to find package for $lib"
    unidentified_libs+=("$lib")
  else
    #echo "$lib is part of $package"
    packages+=("$package")
  fi
done

# Get unique list of packages
IFS=" " read -r -a packages <<< "$(echo "${packages[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
echo "Packages: ${packages[@]}"

############################################
# Get license for each package
if [[ ! -d "$outdir" ]]
then
  mkdir -p "$outdir"
fi
no_license_pkgs=()
mkdir -p "$outdir"
for pkg in "${packages[@]}"
do
  license=$(dpkg -L "$pkg" | grep ".*copyright$")
  if [[ -z "$license" ]]
  then
    echo "Failed to find license for package '$pkg'"
    no_license_pkgs+=("$pkg")
    continue
  fi
  cp "$license" "$outdir"/"${pkg}_LICENSE"
done

echo "Failed to identify libraries that provide ${unidentified_libs[@]}"
echo "Failed to determine licenses for that provide ${no_license_pkgs[@]}"
