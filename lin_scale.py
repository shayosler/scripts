#!/usr/bin/env python
import sys

# Check for arguments
if len(sys.argv) != 5:
    x1 = float(raw_input("Raw Value 1: "))
    y1 = float(raw_input("Scaled Value 1: "))
    x2 = float(raw_input("Raw Value 2: "))
    y2 = float(raw_input("Scaled Value 2: "))
else:
    x1 = float(sys.argv[1])
    y1 = float(sys.argv[2])
    x2 = float(sys.argv[3])
    y2 = float(sys.argv[4])
m = (y2 - y1) / (x2 - x1)
b = y1 - m * x1

print("m = " + str(m))
print("b = " + str(b))
