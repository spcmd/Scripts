#!/bin/sh
# source: https://unix.stackexchange.com/questions/247843/how-to-generate-a-data-uri-from-an-image-file

mimetype=$(file -bN --mime-type "$1")
content=$(base64 -w0 < "$1")
echo "url('data:$mimetype;base64,$content');" | xsel -b
