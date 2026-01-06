#!/usr/bin/env bash

START=75
END=80

BAT="/sys/class/power_supply/BAT0";

if [[ ! -d "$BAT" ]]; then
    echo "Battery not found 😿"
    exit 1
fi

echo "$START" | sudo tee "$BAT/charge_control_start_threshold" > /dev/null
echo "$END" | sudo tee "$BAT/charge_control_end_threshold" > /dev/null

echo "🔋 Battery charge limit set: $START% -> $END%"
