#!/bin/sh

# Tiling indicator for the active workspace. Minimised windows do not count,
# for the same reason workspaces.sh ignores them.

HELPER="$CONFIG_DIR/helpers/onscreen"

onscreen=$("$HELPER" 2>/dev/null | jq -R -s 'split("\n") | map(select(length > 0) | tonumber)')
[ -z "$onscreen" ] && onscreen='[]'

COUNT=$(rift-cli query workspaces 2>/dev/null \
  | jq --argjson on "$onscreen" '
      [ .[] | select(.is_active) | .windows[]?
        | select([.window_server_id] | inside($on)) ] | length
    ') || exit 0

if [ "${COUNT:-0}" -le 1 ]; then
  sketchybar --set "$NAME" label="󰊓" label.color=0xffabb2bf
else
  sketchybar --set "$NAME" label="󰕴" label.color=0xff61afef
fi
