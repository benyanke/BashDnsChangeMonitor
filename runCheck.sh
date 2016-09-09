#!/bin/bash

# Fill in domains below, and run this file in cron

isChange=0

function isUrlChanged() {
	output=$(./checkForDnsChange.sh $1)

	# get current IP, replace NL with " "
	ip=$(dig $1 +short | tr '\n' ' ')

	# remove last space character
	ip=${ip::-1}

	if [ "$output" = "0" ]; then
		echo "x    $1 ($ip)"

		isChange=1;

	else
		echo "     $1 ($ip)"

	fi

	echo ""

}

function seperator() {
	echo "=========================="
	echo ""

}

clear
echo ""
echo "#######################"
echo "DNS Modification Report"
echo "#######################"
echo "(x = change)"
echo ""

isUrlChanged domain1.com
isUrlChanged domain2.com
isUrlChanged google.com

seperator

isUrlChanged yahoo.com
isUrlChanged facebook.com

if [ $isChange == 1 ]; then
	echo "";
	echo "## CHANGE ##";

	# add email alert here

fi
