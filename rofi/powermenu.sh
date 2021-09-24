#!/usr/bin/env bash

theme="card_square"
dir="$HOME/.config/rofi"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $HOME/.config/rofi/card_square"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "﫵 $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		#systemctl poweroff
		msg
		;;
    $reboot)
		#systemctl reboot
		msg
		;;
    $lock)
		#betterlockscreen -l
		msg
		;;
    $suspend)
		#systemctl suspend
		msg
		;;
    $logout)
		#i3-msg exit
		msg
		;;
esac
