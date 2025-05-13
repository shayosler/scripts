#!/bin/bash
num_cores=$1
period=$2
while true
do
    echo "ON"
    last_pid=
    for (( n=0; n<$num_cores; n++))
    do
        load_cpu.sh "$period" &
        last_pid=$!
    done
    wait "$last_pid"
    echo "OFF"
    sleep "$period"
done
