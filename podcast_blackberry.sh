#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# https://github.com/spcmd

# Copy podcasts to the Blackberry podcast dir and append them to the playlist

dir_podcasts=/media/BLACKBERRY/BlackBerry/podcasts
file_playlist="$dir_podcasts/Podcasts.m3u"

for file in "$@"; do

    file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
    filename_wo_ext="${file_renamed%.*}"

    echo "Renaming $file to: $file_renamed"
    mv "$file" "$file_renamed"
    echo "Moving $file_renamed to Blackberry's podcasts dir..."
    mv "$file_renamed" "$dir_podcasts"
    echo "Appending $file_renamed to playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
    echo "Done!"

done
