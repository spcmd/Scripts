#!/bin/bash

# Open different type or URLs with different applications
# (original script: https://github.com/michael-lazar/rtv/issues/78#issuecomment-125507472)

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


# This checks the display, so can be used in both TTY and X
VIDEO="url2mpv.sh"

# Check whether the $DISPLAY is set (running on X) or not
if [[ $DISPLAY ]]; then
    DEFAULT="brave"
    IMAGE="feh -."
    GIF="mpv --loop=inf"

    url=$1
    case $url in
        http*://*youtube.com/watch?*|http*://youtu.be/watch?*|http*://youtu.be/*)
            ${PRE}${VIDEO} "$url"
            #${PRE}urxvtc -hold -e youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s" "${url}"
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
        *.mp3)
            ${PRE}urxvtc -e wget -P ~/Downloads "${url}"
            ;;
        *)
            ${DEFAULT} "$url"
            ;;
    esac

# no display, using tty
else
    DEFAULT="w3m"
    GIF="mpv -vo=drm --loop=inf"

    url=$1
    case $url in
        http*://*youtube.com/watch?*|http*://youtu.be/watch?*)
            ${PRE}${VIDEO} "$url" && clear # clear the output of mpv (quiet and msg-level options didn't work well)
            ;;
        *.jpg*|*.png*)
            # FIM cannot open URLs directly, so we need to download the image(s) first
            DIR_FIM_TMP=/tmp/fim
            wget -q -N -P $DIR_FIM_TMP "$url" && fim ${DIR_FIM_TMP}/${url##*/} > /dev/null 2>&1
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
        *.mp3)
            wget -P ~/Downloads "${url}"
            ;;
        *)
            ${DEFAULT} "$url"
            ;;
    esac

fi

