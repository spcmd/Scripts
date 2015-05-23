#!/bin/bash

# ========================================================= #
# archsi (Arch System Info bash script)                     #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# License: GNU GPLv3 - http://www.gnu.org/copyleft/gpl.html #
# ========================================================= #

# ========================================== #
# ========== CONFIGURABLE OPTIONS ========== #
# ========================================== #

# Show the "real" usage of the disk space (used space + file system reserved for root) and calculate the perctange this way
# Leave it empty if you don't want the reserved space to be counted
SHOW_REAL_USAGE=""

# Colors
COLOR_DEFAULT=$(tput sgr0)
COLOR_TITLE=$(tput setaf 4; tput bold)
COLOR_LOGO=$(tput setaf 4; tput bold)

# ========================================= #
# ====== END OF CONFIGURABLE OPTIONS ====== #
# ========================================= #

# System Info
OS=$(lsb_release -d | awk '{ print $2,$3,$4 }')
KERNEL=$(uname -r)
WM=$(wmctrl -m | grep 'Name' | awk '{ print $2 }')
UPTIME=$(uptime -p | sed 's/up\s//')
CPUINFO=$(cat /proc/cpuinfo | grep 'model name' | cut -d ':' -f2 | sed -e 's/^[ \t]*//' | head -1)

function FREE { free -m  --si ; }

MEMTOTAL=$(FREE | grep 'Mem' | awk '{ print $2 }')
MEMUSED=$(FREE | grep 'Mem' | awk '{ print $3 }')
#MEMFREE=$(FREE | grep 'Mem' | awk '{ print $7 }')
MEMUSEDPERCENT=$((100*$MEMUSED/$MEMTOTAL))

function DFTOTAL { df --total -H | grep 'total' ; }

DISKTOTAL=$(DFTOTAL | awk '{ print $2 }')
#DISKAVAILABLE=$(DFTOTAL | awk '{ print $4 }')

if [[ $SHOW_REAL_USAGE = "yes" ]]; then
    DISKUSED=$(DFTOTAL | sed 's/G//g' | awk '{ printf $2-$4;print "G" }')
    DISKUSEDPERCENT=$(DFTOTAL | sed 's/G//g' | awk '{ printf "%.1f", ($2-$4)/$2*100; print "%" }')
else
    DISKUSED=$(DFTOTAL | awk '{ print $3 }')
    DISKUSEDPERCENT=$(DFTOTAL | sed 's/G//g' | awk '{ printf "%.1f", $3/$2*100; print "%" }')
    #DISKUSEDPERCENT=$(DFTOTAL | awk '{ print $5 }')
fi

CHECKPOWERCORD=$(cat /sys/class/power_supply/ADP1/online)
if [[ $CHECKPOWERCORD = "1" ]]; then
    POWERSTATUS="Plugged in"
else
    POWERSTATUS="On Battery"
fi

# Output
echo -e "\n"
echo -n "$COLOR_LOGO             ▒▒              "; echo "$COLOR_DEFAULT"
echo -n "$COLOR_LOGO            ▒▒▒▒             "; echo -n "$COLOR_TITLE   User:" ; echo "$COLOR_DEFAULT $USER"
echo -n "$COLOR_LOGO           ▒▒▒▒▒▒            "; echo -n "$COLOR_TITLE   Host:" ; echo "$COLOR_DEFAULT $HOSTNAME"
echo -n "$COLOR_LOGO          ▒▒▒▒▒▒▒▒           "; echo -n "$COLOR_TITLE   OS:" ; echo "$COLOR_DEFAULT $OS"
echo -n "$COLOR_LOGO         ▒▒▒▒▒▒▒▒▒▒          "; echo -n "$COLOR_TITLE   Kernel:" ; echo "$COLOR_DEFAULT $KERNEL"
echo -n "$COLOR_LOGO        ▒▒▒▒▒▒▒▒▒▒▒▒▒        "; echo -n "$COLOR_TITLE   WM:" ; echo "$COLOR_DEFAULT $WM"
echo -n "$COLOR_LOGO      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒       "; echo -n "$COLOR_TITLE   Uptime:" ; echo "$COLOR_DEFAULT $UPTIME" 
echo -n "$COLOR_LOGO     ▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒      "; echo -n "$COLOR_TITLE   Power:" ; echo "$COLOR_DEFAULT $POWERSTATUS"
echo -n "$COLOR_LOGO    ▒▒▒▒▒▒▒      ▒▒▒▒▒▒▒     "; echo -n "$COLOR_TITLE   CPU:" ; echo "$COLOR_DEFAULT $CPUINFO"
echo -n "$COLOR_LOGO   ▒▒▒▒▒▒▒        ▒▒▒▒▒▒▒    "; echo -n "$COLOR_TITLE   RAM:" ; echo "$COLOR_DEFAULT ${MEMUSED}M / ${MEMTOTAL}M (${MEMUSEDPERCENT}%)"

echo -n "$COLOR_LOGO  ▒▒▒▒▒▒▒          ▒▒▒▒▒▒▒   "; echo -n "$COLOR_TITLE   HDD:" ; echo "$COLOR_DEFAULT $DISKUSED / $DISKTOTAL ($DISKUSEDPERCENT)"

echo -n "$COLOR_LOGO ▒▒▒▒                  ▒▒▒▒  "; echo "$COLOR_DEFAULT"
echo -e "\n"

