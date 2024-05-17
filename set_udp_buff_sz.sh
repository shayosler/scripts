#!/bin/bash
# Set udp buffer sizes
# Set read buffer max:
sysctl -w net.core.rmem_max="$1"

# Set read buffer default:
sysctl -w net.core.rmem_default="$1"

# Set write buffer max:
sysctl -w net.core.wmem_max="$1"

# Set write buffer default
sysctl -w net.core.wmem_default="$1"
