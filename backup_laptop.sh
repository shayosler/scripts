#!/bin/bash
# Incremental backup of key directories on my laptop

######################################################
# Set up the backup process

#Locations to backup to
#locations=("/media/sosler/4784b102-3e08-4aa3-9f71-1a4f3008306d" "/mnt/so_server")
locations=("/mnt/so_server")

#Files to back up
home="/home/sosler"
backup_targets=("$home/Documents" "$home/images" "$home/logs" "$home/projects" "$home/development")

######################################################
# Copy files from the deployed system to the backup folder
for location in "${locations[@]}"
do
  for d in "${backup_targets[@]}"
  do
    rsync -avzrP "${d}" "${location}"
  done
done


