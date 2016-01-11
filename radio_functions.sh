#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#               radio_functions.sh 
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#
#
#  Usage: source this file in the .bashrc or .zshrc 

# Online radios
radio-classfm() { $MEDIAPLAYER "http://icast.connectmedia.hu/4784/live.mp3" }
radio-radio1() { $MEDIAPLAYER "http://stream.radio1pecs.hu:8200/pecs.mp3" }
radio-mr2petofi() { $MEDIAPLAYER "http://109.199.58.90/4738/mr2.mp3" }
radio-rockradio-60s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/60srock.pls" }
radio-rockradio-80s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/80srock.pls" }
radio-rockradio-90s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/90srock.pls" }
radio-rockradio-bluesrock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/bluesrock.pls" }
radio-rockradio-classicrock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/classicrock.pls" }
radio-rockradio-poprock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/poprock.pls" }

radioplayer() {

    # Define radios
    radio1="http://stream.radio1pecs.hu:8200/pecs.mp3"
    classfm="http://icast.connectmedia.hu/4784/live.mp3"
    mr2petofi="http://109.199.58.90/4738/mr2.mp3"

    # Check if mpv is installed
    if [[ ! -x /bin/mpv ]]; then
        echo '>>> Error: mpv is not installed. Please install mpv first.<<<'
        exit
    fi

    # Play
    mpv --quiet $radio1 &
    echo -e '                  _ _             _                       '
    echo -e '                 | (_)           | |                      '
    echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
    echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
    echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
    echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
    echo -e '                           | |             __/ |          '
    echo -e '                           |_|            |___/           '
    echo "$(tput setaf 4;tput bold)>>> Playing: Radio 1 <<<$(tput sgr0)"
    echo "$(tput setaf 4;tput bold)>>> To switch channel, press a number (1-3) and hit Enter <<<$(tput sgr0)"
    while true
        do
            read switch_to
            if [[ $switch_to == "2" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
                echo "$(tput setaf 4;tput bold)>>> Switching to channel: Class FM <<<$(tput sgr0)"
                mpv --quiet $classfm &
            elif [[ $switch_to == "3" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
echo "$(tput setaf 4;tput bold)>>> Switching to channel: mr2 Petofi <<<$(tput sgr0)"
                mpv --quiet $mr2petofi &
            elif [[ $switch_to == "1" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
echo "$(tput setaf 4;tput bold)>>> Switching to channel: Radio1 <<<$(tput sgr0)"
                mpv --quiet $radio1 &
            elif [[ $switch_to == "q" ]]; then
                pkill mpv
            fi
        done
}
