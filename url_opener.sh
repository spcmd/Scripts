#!/bin/bash

# Source: https://github.com/michael-lazar/rtv/issues/78#issuecomment-125507472

ARGS=$(getopt -o n -- "$@")
PRE=""
q=""
url=""
eval set -- "$ARGS"

while true; do
    case $1 in
        -n)
            # print command that would be run
            PRE="echo "
            # keep this behaviour if we call ourselves recursively (print the final command that will be run)
            q=" -n"
            shift
        ;;
        --)
            shift
            break
        ;;
    esac
done
# let xdg do url scheme handling where appropriate, this script handles special cases (youtube, imgur, etc.)

DEFAULT="luakit"
VIDEO="url2mpv.sh"
IMAGE="feh -."
GIF="mpv --loop=inf"

url=$1
case $url in
    http*://*youtube.com/watch?*|http*://youtu.be/watch?*)
        ${PRE}${VIDEO} "$url"
        ;;
    *.jpg*|*.png*)
        ${PRE}${IMAGE} "$url"
        ;;
    *.gif*)
        ${PRE}${GIF} "${url/.gifv/.webm}"
        ;;
    *imgur.com/a/*|*imgur.com/gallery/*)
        ${DEFAULT} "$url"
        ;;
    *imgur.com/*)
        $0$q $(curl -s "$url" | sed -n 's/^.*<link rel="image_src"\s\+href="\([^"]\+\)".*$/\1/p')
        ;;
    mailto:*)
        ${PRE}urxvtc -e mutt1 -F ~/.mutt/account.1.muttrc -- "${url}"
        ;;
    *)
        ${DEFAULT} "$url"
        ;;
esac
