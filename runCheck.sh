#!/bin/bash

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

clear
echo ""
echo "#######################"
echo "DNS Modification Report"
echo "#######################"
echo "(x = change)"
echo ""

isUrlChanged ballweg.float.publicserver.xyz
isUrlChanged overlook.float.publicserver.xyz

echo "=========================="
echo ""

isUrlChanged lan.office.float.publicserver.xyz
isUrlChanged server1.office.float.publicserver.xyz
isUrlChanged server2.office.float.publicserver.xyz

if [ $isChange == 1 ]; then
	echo "";
	echo "## CHANGE ##";

	# add email alert here

fi
