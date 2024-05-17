#!/bin/bash -x
# Send data from a file, stdin, or an input string repeatedly via socat
#
# Input data is written out with echo -en "..."
# Backslash escapes are enabled, so \r, \n, etc are treated as carriage return, newline, etc.
# Binary data can be sent by inputting it as hex bytes specified with \xNN, e.g. "\x0a\x0d"
# Optionally, binary data consisting of just space separated pairs of hex digits can be sent using the
# -x/--hex_bytes flag
input=""
socat_args=""
delay=1.0
suffix=""
bytes=false
##############################################
# Handle Arguments
# idiomatic parameter and option handling in *sh shells, args passes as --<arg>
if [[ "${1:0:1}" != "-" ]] 
then
  #Just using positional args
  if [[ -n "$1" ]]
  then
    input="$1"
  fi
  if [[ -n "$2" ]]
  then
    socat_args="$2"
  fi
  if [[ -n "$3" ]]
  then
    delay="$3"
  fi
else
  while test $# -gt 0
  do
    case "$1" in
      # Input argument
      -i);&
      --input)
        input=$2
        shift
        ;;
      # Output (socat) argument
      -o);&
      --output)
        socat_args=$2
        shift
        ;;

      # suffix
      -s);&
      --suffix)
        suffix=$2
        shift
        ;;
      
      # Delay argument
      -d);&
      --delay)
        delay=$2
        shift
        ;;

      # Raw bytes
      -x);&
      --hex_bytes)
        bytes=true
        shift
        ;;

      # Catch all other arguments passed as --<arg> here
      --*)
        echo "Unknown option $1"; exit 1
        ;;
      # Catch all other args here
      *)
        echo "Unknown option $1"; exit 1 
        ;;
    esac
    shift
  done
fi

####################################################
# Send data
# If input is a readable file send that one line at a time
# If input is not specified read from stdin
# Otherwise just send input string repeatedly
if [[ -r "$input" || -z "$input" ]]
then
  while true
  do
    while IFS= read -r line || [[ -n "$line" ]]
    do
      line="$(sed -e 's/[[:space:]]*$//' <<< ${line})"
      
      if [[ "$bytes" == "true" ]]
      then
        line="$(sed -re 's/([0-9a-fA-F]{2})/\\x\1/g; s/\s//g' <<< ${line})"
      fi
      echo -en "${line}${suffix}"
      sleep "$delay"
    done < "${input:-/dev/stdin}"
    sleep "$delay"
  done | socat -U $socat_args -
else
  while true
  do
    echo -en "$input"
    sleep "$delay"
  done | socat "$socat_args" -
fi

