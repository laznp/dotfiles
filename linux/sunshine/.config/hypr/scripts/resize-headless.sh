#!/usr/bin/env bash
# Resize the HEADLESS-2 virtual output to match the connecting Moonlight
# client's negotiated resolution/fps (Sunshine prep-cmd sets
# SUNSHINE_CLIENT_WIDTH/HEIGHT/FPS). Falls back to the primary monitor's
# own resolution if those aren't set for some reason.
W="${SUNSHINE_CLIENT_WIDTH:-2560}"
H="${SUNSHINE_CLIENT_HEIGHT:-1440}"
FPS="${SUNSHINE_CLIENT_FPS:-60}"

hyprctl keyword monitor "HEADLESS-2,${W}x${H}@${FPS},2560x0,1"
