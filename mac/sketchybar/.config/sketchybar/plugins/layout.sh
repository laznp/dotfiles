#!/bin/sh

# Tiling indicator for the focused workspace. Minimised windows do not count,
# for the same reason workspaces.sh ignores them.

HELPER="$CONFIG_DIR/helpers/onscreen"

onscreen=$("$HELPER" 2>/dev/null | jq -R -s 'split("\n") | map(select(length > 0) | tonumber)')
[ -z "$onscreen" ] && onscreen='[]'

CURRENT=$(omniwmctl query active-workspace --format json 2>/dev/null \
  | jq -r '.result.payload.workspace.rawName') || exit 0

COUNT=$(omniwmctl query windows --format json 2>/dev/null \
  | jq --argjson on "$onscreen" --arg ws "$CURRENT" '
      [ .result.payload.windows[]
        | select(.isScratchpad | not)
        | select(.workspace.rawName == $ws)
        | select([.windowId] | inside($on)) ] | length
    ') || exit 0

if [ "${COUNT:-0}" -le 1 ]; then
  sketchybar --set "$NAME" label="󰊓" label.color=0xffabb2bf
else
  sketchybar --set "$NAME" label="󰕴" label.color=0xff61afef
fi
