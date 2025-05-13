#!/bin/bash
PORT=/dev/null
BAUD="9600"
DELAY=.01
STR1="\$R,238904.62,1.3,1500*78\r\n"
STR2="\$R,9234982,13,1470.1*5E\r\n"
STR1="\$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0,0031*4F\r\n"
STR2=$STR1
#stty -F $PORT $BAUD
while true
do
    echo -en "$STR1" > $PORT
    echo "$STR1"
    sleep $DELAY
    echo -en "$STR2" > $PORT
    echo "$STR2"
    sleep $DELAY
done






