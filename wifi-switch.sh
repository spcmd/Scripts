#!/bin/bash
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# wifi switch with gmail checker script switching (ON/OFF) for my bspwm & awesomewm

file_gmailcheck_off=/tmp/gmailcheck_off

if [[ $(nmcli radio wifi) = "enabled" ]]; then

    nmcli radio wifi off

    if [[ $(pgrep awesome) ]]; then
        awm-chkmail-off
    fi

    if [[ $(pgrep bspwm) ]]; then
        echo "OFF" > $file_gmailcheck_off
        notify-send "wifi OFF, gmailcheck OFF."
    fi
else
    nmcli radio wifi on

    if [[ $(pgrep awesome) ]]; then
        file_newmail_count=$HOME/.mutt/newmail_count
        echo "0" > $file_newmail_count
        seconds=10s
        sleep $seconds && awm-chkmail-on
    fi

    if [[ $(pgrep bspwm) ]]; then
        rm $file_gmailcheck_off
        notify-send "wifi ON, gmailcheck ON."
    fi
fi
