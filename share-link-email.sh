#!/bin/bash

link=$(xsel -b)

read -p "Subject: " subject

MAIL=$(echo "\"$link\"" "\"$subject\"" "$(cat $HOME/.mailthis)")

printf "mailthis $MAIL" | xsel -b

xdotool key --clearmodifiers "ctrl+shift+v"
