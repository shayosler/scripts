#!/bin/bash
while true
do
  if wget -O - https://lbihealth.com/covid-19-vaccine-scheduling/ | grep -o "vaccination appointments are currently full for the week of 3/15/21"
  then
    echo "[$(date)] No appointments"
  else
    echo "[$(date)] Appointments available"
    google-chrome https://lbihealth.com/covid-19-vaccine-scheduling/
    exit 0
  fi

  sleep 30
done
