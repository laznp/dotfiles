#!/bin/sh

# Repaints every space item in one sketchybar call.
#
# A workspace counts as occupied only if it holds a window macOS still reports
# as on-screen. rift parks the windows of inactive workspaces off-display and
# macOS keeps calling those on-screen, while a minimised window flips to false
# -- that difference is the only reliable minimised signal available here.

HELPER="$CONFIG_DIR/helpers/onscreen"

onscreen=$("$HELPER" 2>/dev/null | jq -R -s 'split("\n") | map(select(length > 0) | tonumber)')
[ -z "$onscreen" ] && onscreen='[]'

args=$(rift-cli query workspaces 2>/dev/null \
  | jq -r --argjson on "$onscreen" '
      .[]
      | . as $w
      | ([ $w.windows[]? | select([.window_server_id] | inside($on)) ] | length) as $n
      | if $w.is_active then
          "--set space.\($w.name) background.drawing=on background.color=0xffD8DEE9 icon.color=0xff1e2127"
        elif $n > 0 then
          "--set space.\($w.name) background.drawing=off background.color=0x00000000 icon.color=0xffabb2bf"
        else
          "--set space.\($w.name) background.drawing=off background.color=0x00000000 icon.color=0xff404142"
        end
    ') || exit 0

[ -n "$args" ] && sketchybar $args
