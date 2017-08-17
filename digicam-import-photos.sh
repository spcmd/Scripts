#!/bin/bash

dir_photos="$HOME/Pictures/Fotók"
dir_import="$dir_photos/$(date +'%Y.%m.%d.')"

read -p "Creating a directory with this name for the imported files: " newdirname

if [[ ! -z $newdirname ]]; then
    mkdir "$dir_import - $newdirname"
else
    echo "No name was given. Exiting."
    exit 1
fi

find "/media/disk/DCIM/100_FUJI" -maxdepth 1 -type f -mtime -1 -exec mv {} "$dir_import - $newdirname" \;
