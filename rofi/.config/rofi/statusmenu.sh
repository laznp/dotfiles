#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/card_square"

# Options
mousebat="󰍽 Mouse Battery"
headphonebat="  Headphone Battery"
datetime="  Date Time"
cputemp="󰍛 CPU Temperature"
gputemp="󰢮  GPU Temperature"

# Variable passed to rofi
options="$mousebat\n$headphonebat\n$datetime\n$cputemp\n$gputemp"

chosen="$(echo -e "$options" | $rofi_command -lines 5 -dmenu -selected-row 2)"
case $chosen in
    $mousebat)
        notify-send "Razer Basilisk Ultimate" $($HOME/.local/bin/razer_battery) -t 1500
        ;;
    $headphonebat)
        notify-send "Sony WH-1000XM4" "$(bluetoothctl info | grep "WH-1000XM4" -A30 | grep Battery | grep -oP '(?<=\().*(?=\))')%" -t 1500
        ;;
    $datetime)
        notify-send "Date Time" "$(date "+%d %b %Y  %H:%M")" -t 1500
        ;;
    $cputemp)
        notify-send "Ryzen 7 5700X" "$(sensors zenpower-pci-00c3 | grep Tdie | awk '{ print $2 }' | tr -d '+')" -t 1500
        ;;
    $gputemp)
        notify-send "Radeon RX 6700 XT" "$(sensors amdgpu-pci-2d00 | grep edge | awk '{ print $2 }' | tr -d '+')" -t 1500
        ;;
esac
