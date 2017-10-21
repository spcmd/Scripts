#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# https://github.com/spcmd

# Set metadata for podcasts

file="$1"
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

echo "${filename}:"
echo "Setting the metadata..."
ffmpeg -i "$file" -metadata title="${filename}" -acodec copy "${filename}_.${extension}" -loglevel fatal
rm "$file"
echo "Done!"
