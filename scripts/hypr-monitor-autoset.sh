#!/usr/bin/enb bash

set -euo pipefail

hyprctl keyword monitor "eDP-1,preferred,auto,1"

if hyprctl monitors | grep -q -E "HDMI|DP"; then
    hyprctl keyword monitor ",preferred,auto,1.5"
fi
