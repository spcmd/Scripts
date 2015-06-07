#!/bin/bash

FIND=$@ 
LINK_TITLE=$(echo $@ | sed 's/ /_/')
LINK=https://en.wikipedia.org/wiki/$LINK_TITLE

w3m $LINK | awk -vRS= -vORS="\n\n" "/^$FIND.+is a(n?)/ {print; exit}" | sed -e 's/\^//g' -e 's/\[[0-9]//g' -e 's/[0-9]\]//g' -e 's/\]//g' -e '/^\s*$/d' 

echo "For further information, please visit: $LINK"
