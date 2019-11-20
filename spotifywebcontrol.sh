#!/bin/bash

# Open an album with dmenu in a spotify web player window (using chrome/chromium and the cvim extension for opening links with the key 'o'). It uses the album_list cache file which was created by my now deprecated spotymenu script.

DMENU='dmenu -i -l 20 -fn Droid-Sans-11 -nb #181818 -nf #ccc -sb #1DB954 -sf #181818'
ALBUM_LIST="$HOME/.spotymenu/album_list"
ALBUM=$(cat "$ALBUM_LIST" | $DMENU)
ALBUM_ID=$(grep "$ALBUM" "$ALBUM_LIST" | awk -F '|' '{print $NF}')
WINDOW=$(xdotool search open.spotify.com__collection_albums | head -n 1)
LINK="https://open.spotify.com/album/$ALBUM_ID"

if [[ ! -z $ALBUM ]]; then

    echo "$LINK" | xsel -p -b && \
    xdotool windowactivate $WINDOW && \
    xdotool key o && \
    sleep 0.2s && \
    xdotool key o && \
    xdotool key space && \
    xdotool key Ctrl+v && \
    xdotool key Return

fi
