#!/usr/bin/env python
import sys

if len(sys.argv) != 2:
  print "First argument must be string to calculate checksum over"
  sys.exit(1)

in_str = sys.argv[1]
cs = 0
if in_str[0] == '$':
  in_str = in_str[1:]

print("Calculating checksum over '" + in_str + "'")
for c in in_str:
  cs = cs ^ ord(c)

print("CS: " + str(hex(cs)))