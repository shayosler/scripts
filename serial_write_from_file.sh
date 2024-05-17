#!/bin/bash
#write the contents of a file to a serial port, with delay between each line
PORT="/dev/pts/5"
BAUD="9600"
FILE=$1
DELAY=1
stty -F $PORT $BAUD

echo "Writing contents of $FILE to $PORT at $BAUD baud"

while read line; do 
  echo $line > $PORT
  sleep $DELAY
  echo "."
done < "$FILE"

echo "Finished"
