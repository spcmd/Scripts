#!/bin/sh
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# Copy esperanto special characters to clipboard and paste them
# Usage: bind this script to key combinations (for example with sxhkd)

case "$1" in
    c) echo $'\U0109' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    g) echo $'\U011d' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    h) echo $'\U0125' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    j) echo $'\U0135' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    s) echo $'\U015d' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    u) echo $'\U016d' | xsel -b && sh -c 'sleep 0.3; xdotool type "$(xsel -ob)"' ;;
    *) exit 0;;
esac
