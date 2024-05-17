#!/bin/bash -x
port=7661
STR="\$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0,0031*4F\r\n"
delay=.1
#while true
#do
#    echo -en "$STR"
#    sleep $delay
#done | socat TCP-LISTEN:$port,fork,reuseaddr -

file="/home/sosler/logs/sample_gps_nmea.txt"
while true
do
    while read -r line || [[ -n "$line" ]]; do
        echo -en "$line\r\n"
        sleep $delay
    done < $file
done| socat TCP-LISTEN:$port,fork,reuseaddr -
