#!/bin/bash
ips=$(nmap -p 22 -n 192.168.1.0-255 | grep 'Nmap scan report for' | cut -f 5 -d ' ')
pw="oh2BnVT"

for ip in $ips; do
  echo "Found: $ip"
  u=$(sshpass -p $pw ssh -o StrictHostKeyChecking=no root@$ip "who" | awk '{print $1}' | uniq) &> /dev/null
  if [ $? -eq 0 ]
  then
    echo "  $u"
  else
    echo "Failed to determine user(s)"
  fi
done
