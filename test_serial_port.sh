#!/bin/bash
port=$1
if [[ -z "$port" ]]
then
    echo "First argument must be port"
    exit 1
fi

stty -F "$port" 9600
while true;
do
    echo "$port $(date)" > "$port"
    echo "$port $(date)"
    sleep 0.5
done
