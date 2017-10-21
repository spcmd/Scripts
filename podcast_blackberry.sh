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

# Different playlists
append_to_playlist_SZFC() {
    file_playlist="$dir_podcasts/SZFC.m3u"
    echo "Appending $file_renamed to SZFC playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}

append_to_playlist_IHSZ() {
    file_playlist="$dir_podcasts/IHSZ.m3u"
    echo "Appending $file_renamed to IHSZ playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}

append_to_playlist_DPC() {
    file_playlist="$dir_podcasts/DPC.m3u"
    echo "Appending $file_renamed to DPC playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}

append_to_playlist_VEGYES() {
    file_playlist="$dir_podcasts/VEGYES.m3u"
    echo "Appending $file_renamed to VEGYES playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}
show_help() {
    echo "Playlist names: szfc, dpc, ihsz, vegyes"
}

case $1 in
    ihsz)
        for file in "${@:2}"; do
            file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            filename_wo_ext="${file_renamed%.*}"
            echo "Renaming $file to: $file_renamed"
            mv "$file" "$file_renamed"
            echo "Moving $file_renamed to Blackberry's podcasts dir..."
            mv "$file_renamed" "$dir_podcasts"
            append_to_playlist_IHSZ
            echo "Done!"
        done
        ;;
    szfc)
        for file in ${@:2}; do
            file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            filename_wo_ext="${file_renamed%.*}"
            echo "Renaming $file to: $file_renamed"
            mv "$file" "$file_renamed"
            echo "Moving $file_renamed to Blackberry's podcasts dir..."
            mv "$file_renamed" "$dir_podcasts"
            append_to_playlist_SZFC
            echo "Done!"
        done
        ;;
    dpc)
        for file in ${@:2}; do
            file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            filename_wo_ext="${file_renamed%.*}"
            echo "Renaming $file to: $file_renamed"
            mv "$file" "$file_renamed"
            echo "Moving $file_renamed to Blackberry's podcasts dir..."
            mv "$file_renamed" "$dir_podcasts"
            append_to_playlist_DPC
            echo "Done!"
        done
        ;;
    vegyes)
        for file in "${@:2}"; do
            file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            filename_wo_ext="${file_renamed%.*}"
            echo "Renaming $file to: $file_renamed"
            mv "$file" "$file_renamed"
            echo "Moving $file_renamed to Blackberry's podcasts dir..."
            mv "$file_renamed" "$dir_podcasts"
            append_to_playlist_VEGYES
            echo "Done!"
        done
        ;;
      -h|--help)
          show_help
          ;;
      ""|*)
          echo "Error! It's not a valid playlist name!"
          show_help
        ;;
esac
