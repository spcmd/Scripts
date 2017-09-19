#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# https://github.com/spcmd

# Connect Blackberry device
# Using Barry (http://www.netdirect.ca/software/packages/barry)

bus=$(lsusb | awk '/Blackberry/{print $2}')
device=$(lsusb | awk '/Blackberry/{gsub(":","");print $4}')

echo "Connecting Blackberry..."
echo "Setting chmod 777 on /dev/bus/usb/$bus/$device"

sudo chmod 777 /dev/bus/usb/$bus/$device
