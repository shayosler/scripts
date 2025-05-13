#!/usr/bin/env python3

# Application for parsing tabular data
# Consider the following data:
#
# Station            Precip   Temperature   Present         Snow
#                   24 Hrs   Max Min Cur   Weather     New Total SWE
# ...Vermont...
# Mount Mansfield              7 -16  -4                     98
# St Johnsbury        0.01    19  -9   8   Cloudy       0.1  22
# Charlotte           0.04                              1.0  11
#
# awk is ill equipped to parse this because not all columns are populated, so
# it is difficult to extract all the data for a particular column

import argparse

parser = argparse.ArgumentParser(description='Process tabular data')
parser.add_argument('-r', '--row', help='The row of the table to select')
parser.add_argument('-c', '--col', help='The column of the table to select')
parser.add_argument('file', metavar='FILE', help='File to parse')
args = parser.parse_args()
