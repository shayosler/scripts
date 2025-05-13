#!/bin/bash
handler()
{
  
  kill $pid2
  echo "killed gss_serial_logger"
  
  kill $pid3
  echo "killed lcm-logplayer"
  
  kill $pid1
  echo "killed socat"
}

log="$1"
channel="$2"
echo "replaying sonar data from lcm log $1 on channel $2"

#open virtual port pair
socat -d -d pty,raw,echo=0,link=/tmp/ttyVSP0 pty,raw,echo=0,link=/tmp/ttyVSP1 &
pid1=$!
sleep 2

#start serial logger
gss_serial_logger port=/tmp/ttyVSP0 channel=$2 settings=115200,8,n,1 record=false &
pid2=$!

#start lcm logplayer
lcm-logplayer-gui $log &
pid3=$!

trap handler SIGINT

wait $pid1 $pid2 $pid3 $pid4

exit 0

