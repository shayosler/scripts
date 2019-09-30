#!/usr/bin/env python3
# Check for RAW images that aren't present in the JPEG directory and vice-versa
#
# First argument should the the directory

import glob
import argparse
import os

# Set up argument parsing
parser = argparse.ArgumentParser()
parser.add_argument("dir")
args = parser.parse_args()

# Parse arguments
dir = args.dir

# Parameters
jpeg_dir = "JPEG"
raw_dir = "RAW"
jpeg_ext = ".JPG"
raw_ext = ".ARW"

# Extract set of RAW and JPEG pictures
jpegs = glob.glob(dir + "/" + jpeg_dir + "/*" + jpeg_ext)
raws = glob.glob(dir + "/" + raw_dir + "/*" + raw_ext)
jpegs = [os.path.basename(j).split('.', 1)[0] for j in jpegs]
raws = [os.path.basename(r).split('.', 1)[0] for r in raws]
raws = set(raws)
jpegs = set(jpegs)

# Determine the deleted RAW/JPEGs
extra_raws = raws - jpegs
extra_jpegs = jpegs - raws

# Print
extra_raw_paths = [dir + "/" + raw_dir + "/" + raw + raw_ext
                   for raw in extra_raws]
extra_jpeg_paths = [dir + "/" + jpeg_dir + "/" + jpeg + jpeg_ext
                    for jpeg in extra_jpegs]

for j in sorted(extra_jpeg_paths):
    print("" + j + "")
for r in sorted(extra_raw_paths):
    print("" + r + "")
    

