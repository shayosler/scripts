#!/bin/bash
ip addr add 10.42.0.2/24 dev eth0
ip route del default
ip route add default via 10.42.0.1 dev eth0
