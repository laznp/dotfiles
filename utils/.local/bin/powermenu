#!/usr/bin/env bash

dir="$HOME/.config/rofi"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $HOME/.config/rofi/card_square"

# Options
shutdown="襤 Poweroff"
reboot="勒 Reboot"
lock=" Lock"
suspend="鈴  Sleep"
logout="  Logout"

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_command -lines 5 -p"﫵 $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		sudo systemctl poweroff
		#msg
		;;
    $reboot)
		sudo systemctl reboot
		#msg
		;;
    $lock)
		betterlockscreen -l dimblur
		#msg
		;;
    $suspend)
		sudo systemctl suspend
		#msg
		;;
    $logout)
        # bspc quit
        hyprctl dispatch exit
		#i3-msg exit
		#msg
		;;
esac
