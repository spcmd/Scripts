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

# Spotify: stop the music when the video starts (requires dbus)
# Options: yes (or leave it blank if you don't want to use this)
SPOTIFY_AUTO_STOP="yes"

# Stop Spotify when the video starts (if the option was set to "yes")
if [ "$SPOTIFY_AUTO_STOP" = "yes" ]; then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
fi

#Play the video
( [ "$DISPLAY" ] && urxvtc -e mpv "$1" ) || mpv -vo=drm "$1"
