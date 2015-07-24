#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                 gmailcheck.sh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#
#
#  Gmail checker script primarily for mutt


# Settings-----------------------------------------

# Number of accounts we will check
# It have to be set exactly!
number_of_accounts=2

# User/Pass for the accounts
# For security reasons, reading the username from the account files and the passwords from a gpg file 
user1=$(cat $HOME/.mutt/account.1.gmail | grep -m 1 "imap_user" | awk '{gsub("\"", "", $4); print $4}')
pw1=$(gpg2 -dq $HOME/.my-pwds.gpg | awk 'NR==1 {print $4}')

user2=$(cat $HOME/.mutt/account.2.gmail | grep -m 1 "imap_user" | awk '{gsub("\"", "", $4); print $4}')
pw2=$(gpg2 -dq $HOME/.my-pwds.gpg | awk 'NR==2 {print $4}')

# Google atom feed url
atom_feed_url="https://mail.google.com/mail/feed/atom"

# Store data in these files
file_newmail_count=$HOME/.mutt/newmail_count
file_newmail_list=$HOME/.mutt/newmail_list
mail_check_log=$HOME/.mutt/mail_check.log

# Account 1 feed-----------------------------------------
mail_1_feed=$(curl -u $user1:$pw1 --silent $atom_feed_url) 
mail_1_account=$(echo "$mail_1_feed" | grep -o -E "[^[:space:]]+@gmail\.com" | head -n 1) 
mail_1_newmail_list=$(echo "$mail_1_feed" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*issued>\(.*\)<\/issued.*name>\(.*\)<\/name>.*/\2 - \3 - \1/p" | awk '{ gsub("T", " ", $1); gsub("Z", "", $1); print $0 }') 

# Account 2 feed-----------------------------------------
mail_2_feed=$(curl -u $user2:$pw2 --silent $atom_feed_url) 
mail_2_account=$(echo "$mail_2_feed" | grep -o -E "[^[:space:]]+@gmail\.com" | head -n 1)
mail_2_newmail_list=$(echo "$mail_2_feed" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*issued>\(.*\)<\/issued.*name>\(.*\)<\/name>.*/\2 - \3 - \1/p" | awk '{ gsub("T", " ", $1); gsub("Z", "", $1); print $0 }') 

# Create Log File-----------------------------------------

if [[ ! -f $mail_check_log ]]; then
    touch $mail_check_log
    echo "Mail check log created at: $(date +%Y.%m.%d\ %H:%M:%S)" > $mail_check_log
fi

# Check mails--------------------------------------

# Create the full list of new mails
full_newmail_list="$mail_1_account\n$mail_1_newmail_list\n$mail_2_account\n$mail_2_newmail_list"
# Count list items
full_newmail_list_count=$(echo -e "$full_newmail_list" | wc -l)
# Substract the number of accounts we check (the number of mail address "headers" in the list)
full_newmail_count=$(( $full_newmail_list_count - $number_of_accounts ))

# Write the list and the count number to files 
echo -e "$full_newmail_list" > $file_newmail_list
echo -e "$full_newmail_count" > $file_newmail_count

# Log: append entries--------------------------------------

# Append log entires to the top (newest on the top)
sed -i "1s/^/Mail checked at: $(date +%Y.%m.%d\ %H:%M:%S)\n/" $mail_check_log
