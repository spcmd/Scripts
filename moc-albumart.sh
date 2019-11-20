#!/bin/bash

CurrentPlayingDir=$(mocp -i | grep "File" | sed -s 's#/[^/]*$##;s/File: //')
AlbumCover=$(ls "${CurrentPlayingDir}"/*.jpg | head -1)
CurrentCoverPathCache=/tmp/moc_current_cover

if [[ -e $AlbumCover ]]; then

    if [[ ! -e $CurrentCoverPathCache ]]; then

        echo "$AlbumCover" > "$CurrentCoverPathCache"
        feh -B '#f1f1f1' "$AlbumCover"

    elif [[ -e $CurrentCoverPathCache && $(cat $CurrentCoverPathCache) = $AlbumCover ]]; then

        if [[ $(pgrep feh) ]]; then
            exit 0
        else
            feh --scale-down -B '#f1f1f1' "$AlbumCover"
        fi

    elif [[ -e $CurrentCoverPathCache && $(cat $CurrentCoverPathCache) != $AlbumCover ]]; then

        if [[ $(pgrep feh) ]]; then
            killall feh
        fi
        echo "$AlbumCover" > "$CurrentCoverPathCache" && feh --scale-down -B '#f1f1f1' "$AlbumCover"

    fi

elif [[ ! -e $AlbumCover ]]; then

    killall feh
    rm "$CurrentCoverPathCache"

else

    killall feh
    rm "$CurrentCoverPathCache"

fi
