#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
# polybar --list-monitors | awk -F ':' '{ print $1 }' | tr -d ' ' | while read line;
# do
    # polybar $line &
# done
polybar HDMI-1 &
# polybar eDP-1 &

echo "Bar launched..."

