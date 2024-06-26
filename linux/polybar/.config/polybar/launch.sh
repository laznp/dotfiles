#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
polybar --list-monitors | awk -F ':' '{ print $1 }' | tr -d ' ' | while read line;
do
    polybar -r $line &
done

# CHECK_MONITOR=$(polybar --list-monitors | awk -F ':' '{ print $1 }' | tr -d ' ' | grep "HDMI")
# if [ $CHECK_MONITOR ]; then
    # polybar HDMI-1 &
# else
    # polybar DP-3 &
# fi

echo "Bar launched..."

