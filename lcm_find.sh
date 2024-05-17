#!/bin/bash -x
# Search for LCM ports

# Search parameters
timeout=.1
if [[ -n "$1" ]]
then
    start_port=$1
else
    start_port=7660
fi

if [[ -n "$2" ]]
then
    stop_port=$2
else
    stop_port=7670
fi
lcm_addr=239.255.76.67

# Random other variables
file=/tmp/socat_out
ports=()

# Calculate address for current route
#my_ip="192.168.1.137"
my_ip=$(ip route get $lcm_addr | sed -n -r -e 's/.*src ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/p')

# Try to receive UDP multicast data for each port in range
for port in $(seq $start_port $stop_port)
do
    > $file
    socat -U -T .1 FILE:$file UDP4-RECVFROM:$port,ip-add-membership=$lcm_addr:$my_ip,reuseaddr &
    pid=$!
    sleep $timeout
    kill $pid &> /dev/null
    rx=$(cat $file)
    if [ -z "$rx" ]
    then
        echo "Received no data on port $port"
    else
        echo "Received data on port $port"
        ports+=($port)
    fi
done

# Print ports we found data for
echo "Found data on ports ${ports[*]}"
