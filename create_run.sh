#!/bin/bash
# Create a .run
# There should be a script called 'install.sh' inside the directory
# that the .run is being built from.
# First argument is name of directory to build
# Second argument is description
if [ $# -lt 2 ]; then
  echo "create_run.sh requires folder name and description"
  exit 1
fi

if [ ! -x $1/install.sh ]
then
  echo "Did not find executable install script named 'install.sh' in $1"
  exit 1
fi

makeself --notemp --target "/tmp/$1" --gzip "$1" "$1.run" "$2" ./install.sh
