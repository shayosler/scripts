#!/bin/bash
time "$@"
echo "Completed at $(date)"
aplay /usr/local/bin/gss_honk.wav
