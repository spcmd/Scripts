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

# simple display rotate script (switch between left and normal)

OUTPUT="eDP1"

rotate_normal(){
    xrandr --output $OUTPUT --rotate normal
}
rotate_left() {
    xrandr --output $OUTPUT --rotate left
}

if [[ $(xrandr | grep "left (normal") ]]; then
    rotate_normal;
else
    rotate_left;
fi
