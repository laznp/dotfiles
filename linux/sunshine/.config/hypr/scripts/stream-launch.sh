#!/usr/bin/env bash
# Usage: stream-launch.sh <workspace> <class-regex> <command...>
# If a window matching class-regex already exists, just move it to the
# given workspace (no relaunch). Otherwise launch command, wait for the
# new window to appear, then silently move it.
# Then BLOCKS until no window of that class remains, so Sunshine (when
# invoked as a monitored "cmd", not "detached") can detect the app closing
# and auto-end the streaming session, however the app was closed.

set -u
WORKSPACE="$1"; shift
CLASS_RE="$1"; shift
BASE_NAME=$(basename "$1")
AUDIO_SINK="sunshine-stream"
LOCAL_SINK="alsa_output.usb-Topping_DX1-00.HiFi__Headphones__sink"
LOCAL_WORKSPACE=4

# Sunshine has a known bug (LizardByte/Sunshine#4950): it forcibly sets
# the system default sink to its own auto-created sink for the whole
# session, regardless of the audio_sink config. That would silently
# suck in any new local audio (Firefox, Spotify, etc), not just the
# streamed app. Keep fighting it back to the real local sink so only
# audio we explicitly move (see move_new_audio) goes to the stream.
force_local_default() {
    cur="$(pactl get-default-sink)"
    [ "$cur" = "$LOCAL_SINK" ] || pactl set-default-sink "$LOCAL_SINK" 2>/dev/null
}

has_match() {
    hyprctl clients -j | jq -e --arg re "$CLASS_RE" \
        'any(.[]; .class | test($re))' >/dev/null
}

# Only move audio belonging to the streamed app's own process tree, not
# "anything new" system-wide -- otherwise unrelated audio that happens
# to start mid-session (e.g. a fresh YouTube tab) gets swept in too.
# The launched binary (e.g. Steam's client daemon) is the real root of
# the process tree -- games/Proton/reaper fork from it directly, not
# from whatever window happens to own the UI (Big Picture's window can
# be a different process, like steamwebhelper).
ROOT_PID=""
resolve_root_pid() {
    pgrep -x "$BASE_NAME" 2>/dev/null | sort -n | head -1
}
descendant_pids() {
    root="$1"
    echo "$root"
    pgrep -P "$root" 2>/dev/null | while read -r child; do
        descendant_pids "$child"
    done
}
move_new_audio() {
    [ -n "$ROOT_PID" ] || return 0
    pids=" $(descendant_pids "$ROOT_PID" | tr '\n' ' ') "
    pactl -f json list sink-inputs 2>/dev/null | jq -r --arg sink "$AUDIO_SINK" \
        '.[] | select((."properties"."application.process.id" // "") != "") |
         "\(.index) \(.properties."application.process.id")"' |
    while read -r sid pid; do
        case "$pids" in
            *" $pid "*) pactl move-sink-input "$sid" "$AUDIO_SINK" 2>/dev/null ;;
        esac
    done
}

# Non-Steam game shortcuts (and PCSX2, launched as a PS2-shortcut child
# of Steam BPM) spawn their own top-level window instead of staying
# embedded in the Steam window like native Steam games do. The
# windowrule substring-matches "steam"/"pcsx2-qt" and sends these to
# workspace 4 on the physical monitor, so catch and move them here too.
CHILD_CLASS_RE='^steam_app_|^pcsx2-qt$'
move_child_game_windows() {
    hyprctl clients -j | jq -r --arg ws "$WORKSPACE" --arg re "$CHILD_CLASS_RE" \
        '.[] | select(.class | test($re)) | select(.workspace.id != ($ws | tonumber)) | .address' |
    while read -r addr; do
        [ -n "$addr" ] && hyprctl dispatch movetoworkspacesilent "$WORKSPACE,address:$addr"
    done
}

existing_addr=$(hyprctl clients -j | jq -r --arg re "$CLASS_RE" \
    '[.[] | select(.class | test($re))][0].address // empty')

# Keep moving whatever currently matches CLASS_RE, for N ticks. Used
# both to wait for a freshly-launched window to appear, and (for Steam
# mode switches) to keep re-asserting the placement while the old
# window tears down and a new one takes its place.
move_matching_for() {
    ticks="$1"
    found=0
    for _ in $(seq 1 "$ticks"); do
        sleep 0.3
        addr=$(hyprctl clients -j | jq -r --arg re "$CLASS_RE" \
            '[.[] | select(.class | test($re))][0].address // empty')
        if [ -n "$addr" ]; then
            hyprctl dispatch movetoworkspacesilent "$WORKSPACE,address:$addr"
            found=1
        fi
    done
    [ "$found" -eq 1 ]
}

if [ -n "$existing_addr" ]; then
    hyprctl dispatch movetoworkspacesilent "$WORKSPACE,address:$existing_addr"
    # If already running, moving the window isn't enough -- e.g. Steam
    # may be sitting in desktop mode, not Big Picture. Steam forwards
    # steam:// URIs to its already-running instance (switches mode
    # in-place, doesn't spawn a duplicate), so resend the launch command
    # in that case. Other apps (PCSX2) don't support this and would just
    # spawn a second instance, so only do it for steam:// commands.
    # Switching modes tears down and recreates the window, so keep
    # re-asserting the placement for a few seconds to catch it too.
    case "$*" in
        *steam://*)
            setsid "$@" &
            move_matching_for 15
            ;;
    esac
else
    setsid "$@" &
    move_matching_for 100 || exit 1
fi

for _ in $(seq 1 20); do
    ROOT_PID=$(resolve_root_pid)
    [ -n "$ROOT_PID" ] && break
    sleep 0.3
done

STREAM_PROPS="$HOME/.local/state/wireplumber/stream-properties"
restore_audio() {
    default_sink=$(pactl get-default-sink)
    sink_idx=$(pactl list short sinks | awk -v s="$AUDIO_SINK" '$2==s{print $1}')
    for id in $(pactl list short sink-inputs | awk -v i="$sink_idx" '$2==i{print $1}'); do
        pactl move-sink-input "$id" "$default_sink" 2>/dev/null
    done

    # WirePlumber's stream-restore silently remembers every move-sink-input
    # as a permanent per-app-name routing rule, which would otherwise leak
    # this session's audio target into unrelated future launches of the
    # same app (e.g. Firefox/YouTube). Strip those pins on exit.
    if [ -f "$STREAM_PROPS" ] && grep -q "\"target\":\"$AUDIO_SINK\"" "$STREAM_PROPS"; then
        sed -i "/\"target\":\"$AUDIO_SINK\"/d" "$STREAM_PROPS"
        systemctl --user restart wireplumber 2>/dev/null
    fi
}

# movetoworkspacesilent only ever moves windows onto the headless output;
# nothing moves them back. If undo doesn't fully close the app (or an app
# like PCSX2 has no undo at all), it's left stranded on HEADLESS-2 even
# for local use afterward. Move any surviving window back to the normal
# physical-monitor workspace on session end.
restore_windows() {
    hyprctl clients -j | jq -r --arg re "$CLASS_RE|$CHILD_CLASS_RE" \
        '.[] | select(.class | test($re)) | .address' |
    while read -r addr; do
        [ -n "$addr" ] && hyprctl dispatch movetoworkspacesilent "$LOCAL_WORKSPACE,address:$addr"
    done
}

restore_headless_res() {
    hyprctl keyword monitor "HEADLESS-2,2560x1440@60,2560x0,1"
}

on_exit() {
    restore_audio
    restore_windows
    restore_headless_res
}
trap on_exit EXIT TERM INT HUP

move_new_audio
move_child_game_windows
force_local_default
while has_match; do
    sleep 1
    [ -n "$ROOT_PID" ] || ROOT_PID=$(resolve_root_pid)
    move_new_audio
    move_child_game_windows
    force_local_default
done
