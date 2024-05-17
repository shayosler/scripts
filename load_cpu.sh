#!/bin/bash
# Script to load 1 CPU
limit=$1
if [[ -n "$limit" || $limit -ge 0 ]]
then
    end=$((SECONDS+$limit))
fi

while [[ $SECONDS -lt $end ]]; do :; done
