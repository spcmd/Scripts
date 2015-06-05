#!/bin/bash
#
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                  gitfile.sh
#               Created by: spcmd
#           http:#spcmd.github.io
#           https:#github.com/spcmd
#           https:#gist.github.com/spcmd
#
# gitfile.sh is a simple shell script which
# allows you to download single files from
# Github.
#
# Dependencies: wget
# Usage: 
#   - Copy & Paste gitfile.sh to somewhere in your $PATH
#   - Then the command will be: gitfile.sh <github url to the file>

rawfile=$(echo $1 | sed "s#blob#raw#")
echo -e "$COLOR_HL1::$COLOR_TITLE gitfile: downloading a single file >$COLOR_HL1 $rawfile $COLOR_DEFAULT"
wget -P ~/Downloads $rawfile
