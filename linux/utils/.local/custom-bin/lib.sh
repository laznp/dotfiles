#!/usr/bin/env bash
# ── Shared library for custom-bin scripts ──

# Color output
red()   { echo -e "\033[0;31m$*\033[0m"; }
green() { echo -e "\033[0;32m$*\033[0m"; }
blue()  { echo -e "\033[0;34m$*\033[0m"; }
warn()  { echo -e "\033[0;33m[WARN]\033[0m $*" >&2; }
die()   { echo -e "\033[0;31m[ERR]\033[0m $*" >&2; exit 1; }

# K8s context check
require_k8s_ctx() {
    local expected="$1"
    local current
    current=$(kubectl config current-context 2>/dev/null) || die "kubectl not configured"
    [[ "$current" == "$expected" ]] || die "Wrong k8s context: $current (expected: $expected)"
}

# Rofi/tofi wrapper
menu_select() {
    local prompt="$1"
    shift
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        echo "$@" | tofi --prompt-text "$prompt"
    else
        echo "$@" | rofi -dmenu -p "$prompt"
    fi
}
