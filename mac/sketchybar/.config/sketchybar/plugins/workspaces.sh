#!/bin/sh

# Repaints every space item in one sketchybar call.
#
# A workspace counts as occupied only if it holds a window macOS still reports
# as on-screen. OmniWM's own counts include minimised windows, and its IPC
# exposes no minimised flag, so the helper supplies that signal instead.

HELPER="$CONFIG_DIR/helpers/onscreen"

onscreen=$("$HELPER" 2>/dev/null | jq -R -s 'split("\n") | map(select(length > 0) | tonumber)')
[ -z "$onscreen" ] && onscreen='[]'

live=$(omniwmctl query windows --format json 2>/dev/null \
  | jq -c --argjson on "$onscreen" '
      [ .result.payload.windows[]
        | select(.isScratchpad | not)
        | select([.windowId] | inside($on))
        | .workspace.rawName ]
      | group_by(.) | map({ key: .[0], value: length }) | from_entries
    ') || exit 0
[ -z "$live" ] && live='{}'

args=$(omniwmctl query workspaces --format json 2>/dev/null \
  | jq -r --argjson live "$live" '
      .result.payload.workspaces[]
      | select(.rawName | test("^[1-9]$"))
      | . as $w
      | (($live[$w.rawName]) // 0) as $n
      | if $w.isCurrent then
          "--set space.\($w.rawName) background.drawing=on background.color=0xffD8DEE9 icon.color=0xff1e2127"
        elif $n > 0 then
          "--set space.\($w.rawName) background.drawing=off background.color=0x00000000 icon.color=0xffabb2bf"
        else
          "--set space.\($w.rawName) background.drawing=off background.color=0x00000000 icon.color=0xff404142"
        end
    ') || exit 0

[ -n "$args" ] && sketchybar $args
