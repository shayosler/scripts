#!/bin/bash
# kernel module for virtual camera device
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2

# launch webcam
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2

# For testing, stream camera to ffplay
# gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0  -f matroska - | ffplay -

