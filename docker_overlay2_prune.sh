#!/bin/bash

dir="$1"
dir="$(basename "$dir")"
found=
for I in $(docker image ls |grep -v IMAGE |awk '{print $3}' |sort |uniq)
do
  F=$(docker image inspect "$I" | grep "$dir")
  if [ -n "$F" ]
  then
    found="true"
    echo "/var/lib/docker/overlay2/${dir}/ is associated with image '$I'"
  fi
done

if [[ -z "$found" ]]
then
  echo "/var/lib/docker/overlay2/${dir}/ is not associated with any image"
fi
