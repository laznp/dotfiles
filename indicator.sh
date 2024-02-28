#!/bin/bash

KEYBOARD=/dev/input/event27
EVENT="type 17 (EV_LED), code 1 (LED_CAPSL), value 1"

evtest "$KEYBOARD" | \
while read line
do
    if [[ "$line" == *"$EVENT" ]]; then
        notify-send -t 700 "Keychron Q8" "Caps Lock ON"
    fi
done
