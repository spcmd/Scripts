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

append_to_playlist_VEGYES() {
    file_playlist="$dir_podcasts/VEGYES.m3u"
    echo "Appending $file_renamed to VEGYES playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}

append_to_playlist_HEADSPACE() {
    file_playlist="$dir_podcasts/HEADSPACE.m3u"
    echo "Copying $file_renamed to HEADSPACE playlist..."
    echo "#EXTINF:-1,$filename_wo_ext" >> "$file_playlist"
    echo "file:///SDCard/BlackBerry/podcasts/$file_renamed" >> "$file_playlist"
}


# For a single playlist
for file in "$@"; do
            file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            filename_wo_ext="${file_renamed%.*}"
            echo "Renaming $file to: $file_renamed"
            mv "$file" "$file_renamed"
            echo "Moving $file_renamed to Blackberry's podcasts dir..."
            mv "$file_renamed" "$dir_podcasts"
            append_to_playlist_VEGYES
            echo "Done!"
done

# For multiple playlist

#case $1 in
    #headspace|h)
        #for file in "${@:2}"; do
            #echo "Moving $file to Blackberry's podcasts dir..."
            #cp "$file" "$dir_podcasts"
            #append_to_playlist_HEADSPACE
            #echo "Done!"
        #done
        #;;
        #vegyes|v|""|*)
        #for file in "${@:2}"; do
            #file_renamed=$(echo "$file" | sed 's/á/a/g;s/é/e/g;s/í/i/g;s/[óöő]/o/g;s/[üűú]/u/g;s/ /_/g')
            #filename_wo_ext="${file_renamed%.*}"
            #echo "Renaming $file to: $file_renamed"
            #mv "$file" "$file_renamed"
            #echo "Moving $file_renamed to Blackberry's podcasts dir..."
            #mv "$file_renamed" "$dir_podcasts"
            #append_to_playlist_VEGYES
            #echo "Done!"
        #done
        #;;
#esac
