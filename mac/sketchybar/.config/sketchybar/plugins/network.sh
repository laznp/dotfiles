#!/bin/sh

# Check ethernet first, then wifi
ETH=$(ifconfig en9 2>/dev/null | grep "status: active")
WIFI=$(ifconfig en0 2>/dev/null | grep "status: active")

if [ -n "$ETH" ]; then
  sketchybar --set "$NAME" icon="󰛳" icon.color=0xffabb2bf label.drawing=off
elif [ -n "$WIFI" ]; then
  SSID=$(networksetup -getairportnetwork en0 2>/dev/null | grep "Current Wi-Fi Network" | sed 's/Current Wi-Fi Network: //')
  if [ -n "$SSID" ]; then
    sketchybar --set "$NAME" icon="󰤨" icon.color=0xffabb2bf label="$SSID" label.drawing=on
  else
    sketchybar --set "$NAME" icon="󰅛" icon.color=0xffE06C75 label.drawing=off
  fi
else
  sketchybar --set "$NAME" icon="󰅛" icon.color=0xffE06C75 label.drawing=off
fi
