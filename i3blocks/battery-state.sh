#!/usr/bin/env bash

GET_PERCENTAGE=$(acpi -b | grep -E -o '[0-9][0-9]?%')
GET_STATE=$(acpi -b | awk -F ',' '{print $1}' | awk -F ':' '{ print $2 }' | tr -d ' ')
if [ "$GET_STATE" == "Charging" ];  then
	echo " $GET_PERCENTAGE"
elif [ "$GET_STATE" == "Full" ]; then
	echo "Full $GET_PERCENTAGE"
else
	echo " $GET_PERCENTAGE"
fi
