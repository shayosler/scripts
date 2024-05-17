#!/bin/bash
socat -d -d pty,rawer,link=/tmp/ttyVSP0 pty,rawer,link=/tmp/ttyVSP1
