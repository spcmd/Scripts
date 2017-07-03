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

# Split podcasts in every 50 mins

file="$1"
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

duration=$(ffprobe -i $file  -show_entries format=duration -v quiet -of csv="p=0" -sexagesimal | awk -F':' '{print $1":"$2}')
duration_sec=$(ffprobe -i $file  -show_entries format=duration -v quiet -of csv="p=0" | awk -F'.' '{print $1}')


# 100 min
if [[ $duration_sec -le 6000 ]]; then
 echo "${filename}:"
 echo "Duration (H:M): $duration"
 echo "Duration (sec): $duration_sec"
 echo "Splitting into 2 pieces..."
 ffmpeg -i "$file" -metadata title="${filename}_1" -ss 00:00:00.000 -t 00:50:00.0 -acodec copy "${filename}_1.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_2" -ss 00:50:00.000 -t 00:50:00.0 -acodec copy "${filename}_2.${extension}" -loglevel fatal
 echo "Done!"
# 150 min
elif [[ $duration_sec -le 9000 ]]; then
 echo "${filename}:"
 echo "Duration (H:M): $duration"
 echo "Duration (sec): $duration_sec"
 echo "Splitting into 3 pieces..."
 ffmpeg -i "$file" -metadata title="${filename}_1" -ss 00:00:00.000 -t 00:50:00.0 -acodec copy "${filename}_1.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_2" -ss 00:50:00.000 -t 00:50:00.0 -acodec copy "${filename}_2.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_3" -ss 01:40:00.000 -t 00:50:00.0 -acodec copy "${filename}_3.${extension}" -loglevel fatal
 echo "Done!"
# 200 min
elif [[ $duration_sec -le 12000 ]]; then
 echo "${filename}:"
 echo "Duration (H:M): $duration"
 echo "Duration (sec): $duration_sec"
 echo "Splitting into 4 pieces..."
 ffmpeg -i "$file" -metadata title="${filename}_1" -ss 00:00:00.000 -t 00:50:00.0 -acodec copy "${filename}_1.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_2" -ss 00:50:00.000 -t 00:50:00.0 -acodec copy "${filename}_2.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_3" -ss 01:40:00.000 -t 00:50:00.0 -acodec copy "${filename}_3.${extension}" -loglevel fatal
 ffmpeg -i "$file" -metadata title="${filename}_4" -ss 02:30:00.000 -t 00:50:00.0 -acodec copy "${filename}_4.${extension}" -loglevel fatal
 echo "Done!"
fi
