#!/bin/bash

# This script does the real work of checking and comparing IPs

if [ -z "$1" ]; then
	echo "Need a URL as a parameter.";
	exit 1;
else
	url=$1;
fi



PATHTOFILE="/home/benyanke/scripts/ipchange/temp"
OLDFILE="$PATHTOFILE/old-$url"
NEWFILE="$PATHTOFILE/new-$url"

# Mv new to old
touch $NEWFILE $OLDFILE
mv $NEWFILE $OLDFILE
touch $NEWFILE $OLDFILE

# Store new data to newfile
dig $1 +short > $NEWFILE


areTheySame=1
cmp --silent $OLDFILE $NEWFILE || areTheySame=0

# If 1, no change since last run
# If 0, there's been a change

echo $areTheySame;
