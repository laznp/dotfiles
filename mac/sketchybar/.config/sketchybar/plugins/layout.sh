#!/bin/sh

COUNT=$(aerospace list-windows --workspace focused 2>/dev/null | wc -l | tr -d ' ')

if [ "$COUNT" -le 1 ]; then
  sketchybar --set "$NAME" label="󰊓" label.color=0xffabb2bf
else
  sketchybar --set "$NAME" label="󰕴" label.color=0xff61afef
fi
