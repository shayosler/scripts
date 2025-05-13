#!/bin/bash

#Copy src.files from local machine to sosler@vpn.greensealive.com:~/ over ssh
# allows resuming
rsync -P --append-verify -vz -e ssh src.files sosler@vpn.greensealive.com:~/

# Continually restart until files are transferred
sleep_sec=5
while [ 1 ]
do
  rsync -P --append-verify -vz -e ssh src sosler@vpn.greensealive.com:~/
  if [ "$?" = "0" ] ; then
    echo "rsync completed normally"
    exit
  else
    echo "rsync failure. Waiting $sleep_sec seconds and retrying..."
    sleep $sleep_sec
  fi
done