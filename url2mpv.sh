#!/bin/sh
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# Stop the music when a video starts
# Stops Spotify and mps-youtube via dbus
# Options: yes / no (or blank)
AUTO_STOP="yes"

# Stop the music
if [ "$AUTO_STOP" = "yes" ]; then

    # Spotify
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop > /dev/null 2>&1

    # mps-youtube
    mpsyt_dest=$(dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply /org/freedesktop/DBus org.freedesktop.DBus.ListNames | awk '/mps-youtube/{gsub("\042","");print $2}' | head -n1)
    mpsyt_status=$(dbus-send --print-reply --session --dest=$mpsyt_dest /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | awk '{gsub("\042","");print $3}' | tail -n1)

    if [ "$mpsyt_status" = "Playing" ]; then
        # pause (don't stop, because 'Stop' really stops the whole playback and won't remember the track number and position)
        dbus-send --type=method_call --dest="$mpsyt_dest" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
    fi

fi

# Play the video
( [ "$DISPLAY" ] && urxvtc -e mpv "$1" ) || mpv -vo=drm "$1"
