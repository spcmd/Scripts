#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# This script converts Steven Black hosts file to a privoxy format action file.
# https://github.com/StevenBlack/hosts
#
# After the conversion you need to copy this file to /etc/privoxy then edit the
# config and add this ABOVE user.action line:
#  actionsfile hosts.action
# then restart the privoxy service

# download
wget --no-verbose https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

echo "Converting to privoxy format..."
# remove commented lines
# remove lines that contains the word 'localhost'
# remove lines that contains the ip 127.0.0.1
# remove lines that contains the ip 255.255.255.255
# remove 0.0.0.0 from the list
# remove leading whitespaces and tabs
sed -r -i \
    -e /^#/d \
    -e/localhost/d \
    -e /127.0.0.1/d \
    -e /255.255.255.255/d \
    -e 's/0.0.0.0//g' \
    -e '/^\s*$/d' \
    -e 's/^[ \t]*//' hosts

# add block action
sed -i '1 i\{ +block{hosts} }' hosts
# rename file
mv hosts hosts.action

echo "Done converting."

# move file to /etc/privoxy ?
echo "Move hosts.action to /etc/privoxy ? [yY/nN]"
read -r answer
if [[ $answer == "y" || $answer == "Y" || $answer == "yes" ]]; then
    sudo mv hosts.action /etc/privoxy
fi
