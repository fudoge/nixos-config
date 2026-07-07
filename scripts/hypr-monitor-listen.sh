#!/usr/bin/env bash

set -euo pipefail

SOCK="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat - UNIX-CONNECT:"$SOCK" - | while read -r line; do
    case "$line" in
    monitoradded* | monitorremoved*)
        sleep 1
        "$HOME/.local/bin/hypr-monitor-autoset.sh"
        ;;
    esac
done
