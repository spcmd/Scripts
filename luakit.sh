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

# A luakit wrapper script
# Based on: https://gopherproxy.meulie.net/uninformativ.de/0/twitpher/2012-05/2012-05-16.txt

# Features:
#   - Export noscript database to plain text (.sql) file for dotfiles syncing.
#   - Export cookie database to plain text (.sql) file for inspection and clean up.
#   - Clean up all cookies (except those that are in the keepcookies_list) when luakit starts.
#     This way domains can be allowed or whitelisted (temporary) and their cookies will be deleted if the
#     domains aren't on the keepcookies_list.


# noscript files (db = binary database, sql = plain text) 
noscript_sql=~/.local/share/luakit/noscript.sql
noscript_db=~/.local/share/luakit/noscript.db

# cookie files (db = binary database, sql = plain text) 
cookies_sql=~/.local/share/luakit/cookies.sql
cookies_db=~/.local/share/luakit/cookies.db

# keep cookies from these domains
keepcookies_list=~/.config/luakit/keepcookies.list

# cleaned, plain text sql file, this will be injected when luakit starts
# contains only cookies from the 'keepcookies_list' 
cleaned_cookies_sql=/tmp/cleaned_cookies_sql

# keep these cookies and remove every other
# read from file, join lines, separate domains with a '|' and remove '*' wildcard
kc=$(sed -e :a -e '$!N; s/\n/|/; ta' -e 's/\*//g' $keepcookies_list)

# print the new sql command but delete the 'INSERT INTO' lines which contain domains that are not whitelisted
awk '{if($0 ~ /^INSERT/ && !/'"$kc"'/) next; print $0}' $cookies_sql > $cleaned_cookies_sql

if ! pgrep '^luakit$'
then
         : > $noscript_db
         sqlite3 $noscript_db < $noscript_sql
         : > $cookies_db
         sqlite3 $cookies_db < $cleaned_cookies_sql
         luakit "$@"
         sqlite3 $noscript_db '.dump by_domain' > $noscript_sql
         sqlite3 $cookies_db '.dump moz_cookies' > $cookies_sql

else
         luakit "$@"
fi
