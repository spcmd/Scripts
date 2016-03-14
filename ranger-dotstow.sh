#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# Stow dotfiles from ranger
# Setup & Usage: 
#   1) Put this script somewhere in your $PATH
#   2) Configure dotfiles_dir variable below.
#   3) Add the stow alias to ranger's rc.conf:
#       alias stow shell ranger-dotstow.sh %s
#   4) Go to your dotfiles_dir in ranger,
#      select a directory or multiple directories 
#      (in the root of the dotfiles_dir)
#      then run the stow command on it.

dotfiles_dir=$HOME/dotfiles

for dirs in $@; do
    if [[ -d $dotfiles_dir/$dirs ]]; then
        stow $dirs
        notify-send "ranger-dotstow" "OK! $dotfiles_dir/$dirs symlinked."
    else
        notify-send "ranger-dotstow" "FAILED! No such directory: $dotfiles_dir/$dirs"
    fi
done
