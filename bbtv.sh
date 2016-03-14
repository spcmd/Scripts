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

# bbtv.sh is a shell script which allows you
# to download or stream videos from bbtv.hu
#
# Dependencies: mpv, youtube-dl
# Usage/Help: /path/to/bbtv.sh -h

if [[ $1 = "-h" ]]; then
    echo "bbtv.sh"
    echo "Dependencies: youtube-dl, mpv"
    echo "-------------------------------------------"
    echo "Usage (if bbtv.sh is aliased to bbtv):"
    echo "-------------------------------------------"
    echo -e "bbtv <number>      Download episode."
    echo -e "bbtv -w <number>   Watch/Stream episode."
    echo -e "bbtv -h            This help."
    echo "-------------------------------------------"
elif [[ $1 = "-w" ]]; then
    mpv http://www.bbtv.hu/bbtv-$2
else
    youtube-dl -o "~/Downloads/%(title)s.%(ext)s" http://www.bbtv.hu/bbtv-$1
fi

