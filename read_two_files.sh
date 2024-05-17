#!/bin/bash

#while IFS='' read -r f1 || [[ -n "$f1" ]] && read -r f2 <&3 || [[ -n "$f2" ]]; do
#while IFS='' read -r f1 && read -r f2 <&3 || [[ -n "$f1" || -n "$f2" ]]; do
    #while read -r f1 && read -r f2 <&3; do
#while { IFS= read -r f1 || [[ -n "$f1" ]]; } && { IFS= read -r f2 <&3 || [[ -n "$f2" ]]; }; do
while { IFS= read -r f1 || [[ -n "$f1" ]]; } && { IFS= read -r f2 <&3 || [[ -n "$f2" ]]; }; do
    echo "f1: $f1"
    echo "f2: $f2"
    sleep .5
done < file1 3<file2


#while true; do
#    read -r f1 <&3 || if [[ -z "$f1" ]]; then break; fi;
#    read -r f2 <&4 || if [[ -z "$f2" ]]; then break; fi;
#    echo "f1: $f1"
#    echo "f2: $f2"
#    sleep .5
#done 3<file1 4<file2
