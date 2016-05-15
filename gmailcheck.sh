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


# General Settings-----------------------------------------

# Google atom feed url
atom_feed_url="https://mail.google.com/mail/feed/atom"

# Store data in these files
file_newmail_count=$HOME/.mutt/newmail_count
file_newmail_list=$HOME/.mutt/newmail_list
mail_check_log=$HOME/.mutt/mail_check.log

# Log the time and date of the check
checkdatetime=$(date +%Y.%m.%d\ %H:%M:%S)

# Log file & OFF switch -----------------------------------------

if [[ ! -e $mail_check_log ]]; then
    touch "$mail_check_log"
    echo "Mail check log created at: $checkdatetime" > "$mail_check_log"
fi

# Don't check mail if switched OFF
if [[ -e /tmp/gmailcheck_off ]]; then
    sed -i "1s/^/Mail check turned OFF, exited at: $checkdatetime\n/" "$mail_check_log"
    exit
fi

# Account Settings-----------------------------------------

# User/Pass for the accounts
# For security reasons, reading the username from the account files and the passwords from a gpg file
user1=$(grep -m 1 "imap_user" "$HOME/.mutt/account.1.muttrc" | awk '{gsub("\"", "", $4); print $4}')
pw1=$(gpg2 -dq "$HOME/.pwds-mutt.gpg" | awk 'NR==1 {print $4}')

user2=$(grep -m 1 "imap_user" "$HOME/.mutt/account.2.muttrc" | awk '{gsub("\"", "", $4); print $4}')
pw2=$(gpg2 -dq "$HOME/.pwds-mutt.gpg" | awk 'NR==2 {print $4}')

# Account 1 feed-----------------------------------------
mail_1_feed=$(curl -u "$user1:$pw1" --silent $atom_feed_url)
mail_1_account=$(echo "$mail_1_feed" | grep -o -E "[^[:space:]]+@gmail\.com" | head -n 1)
mail_1_newmail_list=$(echo "$mail_1_feed" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*issued>\(.*\)<\/issued.*name>\(.*\)<\/name>.*/\2 - \3 - \1/p" | awk '{ gsub("T", " ", $1); gsub("Z", "", $1); print $0 }')
mail_1_newmail_count=$(echo "$mail_1_feed" | grep -E -o '<fullcount>[0-9]{1,3}</fullcount>' | sed -e 's/<fullcount>//;s/<\/fullcount>//')

# Account 2 feed-----------------------------------------
mail_2_feed=$(curl -u "$user2:$pw2" --silent $atom_feed_url)
mail_2_account=$(echo "$mail_2_feed" | grep -o -E "[^[:space:]]+@gmail\.com" | head -n 1)
mail_2_newmail_list=$(echo "$mail_2_feed" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*issued>\(.*\)<\/issued.*name>\(.*\)<\/name>.*/\2 - \3 - \1/p" | awk '{ gsub("T", " ", $1); gsub("Z", "", $1); print $0 }')
mail_2_newmail_count=$(echo "$mail_2_feed" | grep -E -o '<fullcount>[0-9]{1,3}</fullcount>' | sed -e 's/<fullcount>//;s/<\/fullcount>//')

# Check mails--------------------------------------

# Count new mails (using fullcount entries)
full_newmail_count=$((mail_1_newmail_count + mail_2_newmail_count))

# Create the list of new mails if there is at least one new mail
if [[ $full_newmail_count -ge "1" ]]; then

    # Check if has any new mail, else don't write the account name in the full list
    if [[ $mail_1_newmail_count -ge "1" ]]; then
        mail_1_listing="\n──────[ $mail_1_account ]──────────────────────────────────────\n$mail_1_newmail_list\n"
    else
        mail_1_listing=""
    fi

    # Check if has any new mail, else don't write the account name in the full list
    if [[ $mail_2_newmail_count -ge "1" ]]; then
        mail_2_listing="\n──────[ $mail_2_account ]──────────────────────────────────────\n$mail_2_newmail_list"
    else
        mail_2_listing=""
    fi

    # Create the final list
    full_newmail_list="\nLast checked: $checkdatetime\n$mail_1_listing$mail_2_listing"

else
    full_newmail_list="\n No new mail.\n Last checked: $checkdatetime"
fi

# Write the list and the count number to files
echo -e "$full_newmail_list" > "$file_newmail_list"
echo -e "$full_newmail_count" > "$file_newmail_count"

# Debug
#echo -e "FULL_LIST: $full_newmail_list"
#echo -e "FULL_COUNT: $full_newmail_count"
#echo -e "MAIL_1_COUNT: $mail_1_newmail_count"
#echo -e "MAIL_2_COUNT: $mail_2_newmail_count"

# Window Manager panel/widget --------------------------------------

# awesome WM
if [[ $(pgrep awesome) ]]; then

    # Pipe newmail count into awesome-client (refresh mail widget)
    if [[ $full_newmail_count -ge "1" ]]; then
        #echo "mail_widget:set_markup(\" <span background='#C90303' color='#ffffff'>${full_newmail_count}new</span> \")" | awesome-client
        echo "mail_widget:set_markup(\"Mail: <span background='#C90303' color='#ffffff'> ${full_newmail_count}new </span> \")" | awesome-client
    else
        #echo 'mail_widget:set_text(" 0 ")' | awesome-client
        echo "mail_widget:set_text(\"Mail: 0\")" | awesome-client
    fi

fi

# bspwm
if [[ $(pgrep bspwm) ]]; then

    if [[ $full_newmail_count -gt 0 ]]; then
       echo "M%{F#ff3b3b}${full_newmail_count}new" > "$PANEL_FIFO"
    else
        echo "M0" > "$PANEL_FIFO"
    fi

fi

# Log: append entries--------------------------------------

# Append log entires to the top (newest on the top)
sed -i "1s/^/Mail checked at: $checkdatetime\n/" "$mail_check_log"
