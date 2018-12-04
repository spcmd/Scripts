#!/bin/bash

#  Script to pause the track and quiet the client with a single key in MOC player
#
# in ~/.moc/keymap set:
#   quit_client           = F1
#   exec_command1         = q
# in ~/.moc/config set:
#   ExecCommand1 = "/home/YOURNAME/PATH_TO/mocp-quit-client.sh"


mocp --pause
xdotool key F1
notify-send "mocp client has quit, server is still running..."
