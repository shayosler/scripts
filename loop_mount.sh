#!/bin/bash -ex
# Loop mount a disk image/device
# Usage:
# loop_mount.sh -i FILE -o MOUNTPOINT [-p PARTITION]
# Mounts PARTITION from FILE on MOUNTPOINT
# PARTITION is the 1-indexed partition number to mount.

partition=0
while test $# -gt 0
do
    case "$1" in
        # Input argument
        -i);&
        --input)
            input=$2
            shift
            ;;
        # Output (socat) argument
        -o);&
        --output)
            mountpoint=$2
            shift
            ;;

        # suffix
        -p);&
        --partition)
            partition=$2
            shift
            ;;

        #Catch all other arguments passed as --<arg> here
        --*)
            echo "Unknown option $1"; exit 1
            ;;
        #Catch all other args here
        *)
            echo "Unknown option $1"; exit 1 
            ;;
    esac
    shift
done

# Parse sector size
size=$(fdisk -lu 20180524_ap_box_r05.img | sed -E -n 's/Units.*= *([0-9]+) *bytes$/\1/p')

# Parse partition start sector
part_name="${input}${partition}"
start=$(fdisk -lu -o Device,Start "$input" | awk -v part_name="$part_name" '$1==part_name {print $2}')

# Mount
start_bytes=$((size * start))
mount -o loop,offset="$start_bytes" "$input" "$mountpoint"
