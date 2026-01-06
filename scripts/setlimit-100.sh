#!/usr/bin/env bash
BAT="/sys/class/power_supply/BAT0";
if [[ ! -d "$BAT" ]]; then
    echo "Battery not found 😿"
    exit 1
fi
echo "100" | tee "$BAT/charge_control_end_threshold" > /dev/null

echo "🔋 Travel mode: 100%"
