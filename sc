#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#              sc (spotify control)
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#
# Control Spotify from the command line.
# Dependencies: xsel, feh

DBUS_SPOTIFY="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2"
DBUS_PLAYER="org.mpris.MediaPlayer2.Player"
DBUS_GET_META="$DBUS_SPOTIFY org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata"
DBUS_CALL="dbus-send  --print-reply --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri"

meta_Artist="$($DBUS_GET_META | awk 'c&&!--c;/"xesam:artist"/{c=2}' | awk '{ gsub("string",""); gsub("\042",""); gsub(/^[ \t]+/,""); print $0 }')"
meta_AlbumArtist="$($DBUS_GET_META | awk 'c&&!--c;/"xesam:albumArtist"/{c=2}' | awk '{ gsub("string",""); gsub("\042",""); gsub(/^[ \t]+/,""); print $0 }')"
meta_Title="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"xesam:title"/{f=1}')"
meta_Album="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"xesam:album"/{f=1}')"
meta_TrackURL="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"xesam:url"/{f=1}')"
meta_TrackID="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"mpris:trackid"/{f=1}')"
meta_TrackNumber="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"xesam:trackNumber"/{f=1}')"
meta_ArtURL="$($DBUS_GET_META | awk 'f{$1=$2=""; gsub("\042",""); gsub(/^[ \t]+/,""); print $0;f=0} /"mpris:artUrl"/{f=1}')"

sc_ascii() {
echo -e "\033[1;32m
 ___  ___
/ __|/ __|                   []
\__ \ (__  spotify control [][][]
|___/\___|                   []
\033[0m"
}

case $1 in
    -a|--artist)
        echo "$meta_Artist"
        ;;
    -A|--albumartist)
        echo "$meta_AlbumArtist"
        ;;
    -b|--album)
        echo "$meta_Album"
        ;;
    -c|--coverurl|--arturl)
        echo "$meta_ArtURL"
        ;;
    -C|--viewcover|--viewart)
        feh $($0 -c) &
        ;;
    -d|--trackid)
        echo "$meta_TrackID"
        ;;
    -D|--copyid)
        echo "$meta_TrackID" | xsel -b
        echo "Track ID copied to the clipboard"
        ;;
    -i|--info)
        sc_ascii;
        echo -e "\033[1;32mArtist:\033[0m $meta_Artist"
        echo -e "\033[1;32mTitle:\033[0m $meta_Title"
        echo -e "\033[1;32mAlbum:\033[0m $meta_Album"
        echo -e "\033[1;32mTrack:\033[0m $meta_TrackNumber"
        echo ""
        ;;
    -I|--details)
        sc_ascii;
        echo -e "\033[1;32mArtist:\033[0m $meta_Artist"
        echo -e "\033[1;32mTitle:\033[0m $meta_Title"
        echo -e "\033[1;32mAlbum:\033[0m $meta_Album"
        echo -e "\033[1;32mTrack:\033[0m $meta_TrackNumber"
        echo -e "\033[1;32mAlbum Artist:\033[0m $meta_AlbumArtist"
        echo -e "\033[1;32mTrackID:\033[0m $meta_TrackID"
        echo -e "\033[1;32mTrackURL:\033[0m $meta_TrackURL"
        echo -e "\033[1;32mArtURL:\033[0m $meta_ArtURL"
        echo ""
        ;;
    -m|--meta)
        $DBUS_GET_META
        ;;
    -n|--next)
        $DBUS_SPOTIFY $DBUS_PLAYER.Next > /dev/null
        ;;
    -p|--playpause)
        $DBUS_SPOTIFY $DBUS_PLAYER.PlayPause > /dev/null
        ;;
    -r|--previous)
        $DBUS_SPOTIFY $DBUS_PLAYER.Previous > /dev/null
        ;;
    -s|--search)
        type="$2"
        query=$(echo "$3" | sed 's/ /+/g')
        spotify_uri="$(curl -s "https://api.spotify.com/v1/search?q=$query&type=$type" | grep --color=never -E -o "spotify:$type:[a-zA-Z0-9]+" -m 1)"
        if [[ ! -z $type ]] && [[ ! -z $query ]];then
            echo "==> Found: $spotify_uri"
            $DBUS_CALL "string:$spotify_uri" > /dev/null && echo "==> Done: loading to Spotify"
        else
            echo "==> Error: you must specify a 'type' and a search 'query'."
            echo "    Use quotes around the query string!"
            echo "    Usage example:"
            echo "      $(basename $0) $1 artist \"clint mansell\""
        fi
        ;;
    -t|--title)
        echo "$meta_Title"
        ;;
    -T|--tracknumber)
        echo "$meta_TrackNumber"
        ;;
    -u|--trackurl)
        echo "$meta_TrackURL"
        ;;
    -h|--help|*)
        sc_ascii;
        echo -e "Usage: $(basename $0) [option] [type]\n"
        echo "Options:"
        echo "   -a, --artist                     Print the artist"
        echo "   -A, --albumartist                Print the album artist"
        echo "   -b, --album                      Print the album title"
        echo "   -c, --coverurl, --arturl         Print the cover art's url"
        echo "   -C, --viewcover, --viewart       View the covert art with feh"
        echo "   -d, --trackid                    Print the track id"
        echo "   -D, --copyid                     Copy track id to the clipboard"
        echo "   -i, --info                       Print basic information about the current track"
        echo "   -I, --details                    Print detailed information about the current track"
        echo "   -m, --meta                       Print the 'raw' metadata"
        echo "   -n, --next                       Play the next track"
        echo "   -p, --playpause                  Play/Pause the current track"
        echo "   -r, --previous                   Play the previous track"
        echo "   -s, --search [type] '<query>'    Search for the query with a type (artist,track,album)."
        echo "   -t, --title                      Print the track title"
        echo "   -T, --tracknumber                Print the track number"
        echo "   -u, --trackurl                   Print the track url"
        ;;
esac
