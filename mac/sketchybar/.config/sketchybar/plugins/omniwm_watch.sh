#!/bin/sh

pkill -f 'omniwmctl watch active-workspace' 2>/dev/null

omniwmctl watch active-workspace,windows-changed --reconnect \
  --exec sketchybar --trigger omniwm_workspace_change >/dev/null 2>&1 &
