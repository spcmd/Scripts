#!/bin/sh

# rename 'tips & notes' pdf files downloaded with the printfriendly browser extension (https://www.printfriendly.com/extensions/chrome)

# files are notes for this language name or code
lang="eo"

# remove domain address from the filenames
rename 'duolingo.com-' '' *.pdf

# change spaces to underscores in the filenames
rename ' ' '_' *.pdf

# rename files by adding a pattern to the filenames
for file in *.pdf; do mv "$file" "${lang}-${file}"; done
