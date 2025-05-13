#!/bin/bash -i
# redo previously executed command with any arguments inserted between the command and the previously
# specified arguments
cmd="$(history -p !!:0) $@ $(history -p !!:*)"
eval $cmd
history -s $cmd
