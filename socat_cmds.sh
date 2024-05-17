#!/bin/bash
# Useful socat commands

#Create virtual serial port pair
socat -d -d pty,raw,echo=0 pty,raw,echo=0

#Listen to UDP on port 5000, output to stdout
socat - udp4-listen:5000,reuseaddr,fork

#Read from stdin, send UDP packet so 127.0.0.1:5000
echo "hello" | socat - udp-sendto:127.0.0.1:5000

# Receive over tcp from 127.0.0.1 port 80 and write it to stdout
socat TCP:127.0.0.1:80 -

# Receive data over TCP from 192.168.1.39 port 4003 and output it over a serial
# PTY
socat -d -d TCP:192.168.1.39:4003 pty,raw,echo=0

# Send/receive data with SSL encryption, don't verify identity of the server we're connecting to
# See http://www.dest-unreach.org/socat/doc/socat-openssltunnel.html for info on generating key/crt/pem fileschmod
socat - OPENSSL:localhost:30001,cafile=server.pem,verify=0