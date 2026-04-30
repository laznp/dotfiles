#!/bin/sh

BADGE=$(lsappinfo info -only StatusLabel "Slack" 2>/dev/null | grep -o '"label"="[^"]*"' | sed 's/"label"="//;s/"//')

if [ -z "$BADGE" ]; then
  # No notifications
  sketchybar --set "$NAME" \
    icon.color=0xffabb2bf \
    label.drawing=off
elif echo "$BADGE" | grep -qE '^[0-9]+$'; then
  # Mention or DM — red dot
  sketchybar --set "$NAME" \
    icon.color=0xffE01E5A \
    label="●" \
    label.color=0xffE01E5A \
    label.font="JetBrainsMono Nerd Font:Bold:8.0" \
    label.drawing=on
else
  # Unread messages, no mention — blue dot
  sketchybar --set "$NAME" \
    icon.color=0xff61afef \
    label="●" \
    label.color=0xff61afef \
    label.font="JetBrainsMono Nerd Font:Bold:8.0" \
    label.drawing=on
fi
