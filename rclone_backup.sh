#!/bin/bash
rclone copy \
       --update \
       --verbose \
       --transfers 30 \
       --checkers 8 \
       --contimeout 60s \
       --timeout 300s \
       --retries 3 \
       --low-level-retries 10 \
       --stats 1s \
       "/home/sosler/" "gss-drive:Backups/$(date -I)_$(hostname)_$(lsb_release -si)_$(lsb_release -sr)/home/sosler/"
