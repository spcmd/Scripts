#!/bin/bash
#
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#               mpv-watch-later.sh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#
# mpv-watch-later.sh is a shell script which
# allows you to list the files from mpv's watch_later 
# directory and select from them to play with mpv.
#
# Dependencies: mpv, youtube-dl, xsel
# Usage: 
#   - Copy & Paste mpv-watch-later.sh to somewhere in your $PATH
#   - Then the command will be: mpv-watch-later.sh 


COLOR_DEFAULT=$(tput sgr0)
COLOR_TITLE=$(tput setaf 7; tput bold)
COLOR_HL1=$(tput setaf 4; tput bold)
COLOR_HL2=$(tput setaf 5; tput bold)
COLOR_YELLOW_BG=$(tput setab 3; tput setaf 0)
COLOR_YELLOW_FG=$(tput setaf 3; tput bold)

dir=$HOME/.config/mpv/watch_later
number=0

echo -e "$COLOR_HL1::$COLOR_TITLE mpv-watch-later >$COLOR_DEFAULT Listing watch_later:"
for file in $dir/*
do
    number=$((number + 1))
    filepath=$(head -n 1 $file | sed 's/# //')
    arr+=($filepath)
    if [[ $filepath =~ ^http(s?).+$ ]]; then

        echo $filepath | xsel -b && echo "$COLOR_YELLOW_BG$number$COLOR_DEFAULT$COLOR_HL2 $(youtube-dl --get-title $filepath) $COLOR_DEFAULT [$(xsel -b)] [$(basename $file)]"
    else
        echo $filepath | xsel -b && echo "$COLOR_YELLOW_BG$number$COLOR_DEFAULT$COLOR_HL2 $(basename $(xsel -b)) $COLOR_DEFAULT [$(xsel -b)] [$(basename $file)]"
    fi
done
#echo "Array check: ${arr[*]}"
echo -n "$COLOR_YELLOW_FG==>$COLOR_DEFAULT Play with mpv [select a number, q = quit]: " ; read selectnumber
if [[ $selectnumber == "q" ]] || [[ $selectnumber == "Q" ]]; then
    exit; # quit
else
    selectnumber=$selectnumber-1 # the list starts with 1, but the array starts with 0, so we need to substract 1 from the 'selectnumber' (1=element0,2=element1 etc.)
    mpv "${arr[$selectnumber]}" # play the selected file
fi
