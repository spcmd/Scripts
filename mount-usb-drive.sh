#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# https://github.com/spcmd


usb_drive=$(lsblk | grep sdb1)

case $1 in
    mount)
        if [[ $usb_drive ]]; then
            udisksctl mount -b /dev/sdb1
        else
            udisksctl mount -b /dev/sdb
        fi
        ;;
    unmount)
        if [[ $usb_drive ]]; then
            udisksctl unmount -b /dev/sdb1
        else
            udisksctl unmount -b /dev/sdb
        fi
        ;;
    "",*)
        exit 0
esac
