#!/bin/bash -x
# Stream a file via ffmpeg

####################################################
# Argument handling
if [[ "${1:0:1}" != "-" ]]
then
  # Positional Arguments
  src="$1"
  dest="${2:-udp://239.255.76.67:52490}"
  fmt="${3:-h264}"
else
  # Args passed as --arg [val]
  # Default values
  src="$1"
  dest="udp://239.255.76.67:52490"
  fmt="h264"
  loop=
  while test $# -gt 0
  do
    case "$1" in
      --src)
        src="$2"
        shift
        ;;
      --dest)
        dest="$2"
        shift
        ;;
      --fmt)
        fmt="$2"
        shift
        ;;
      --loop)
        loop=("-stream_loop" "-1")
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
fi

####################################################
# Validate arguments
if [[ -z "$src" ]]
then
  echo "Error, source file is required"
  exit 1
fi

####################################################
# Stream
ffmpeg ${loop[@]} -re -i "$src" -f "$fmt" "$dest"
