#!/bin/sh

# $NAME is e.g. "space.1", $FOCUSED_WORKSPACE is set by aerospace_workspace_change trigger
sid="${NAME#space.}"

if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
  # Active/focused workspace
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffD8DEE9 \
    icon.color=0xff1e2127
elif aerospace list-windows --workspace "$sid" 2>/dev/null | grep -q .; then
  # Occupied but not focused
  sketchybar --set "$NAME" \
    background.drawing=off \
    background.color=0x00000000 \
    icon.color=0xffabb2bf
else
  # Empty workspace
  sketchybar --set "$NAME" \
    background.drawing=off \
    background.color=0x00000000 \
    icon.color=0xff404142
fi
