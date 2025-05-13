#!/bin/bash
while read line
do
  echo "[$(date +%s.%N)] : $line"
done