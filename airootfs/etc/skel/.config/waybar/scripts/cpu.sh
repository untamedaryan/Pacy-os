#!/bin/bash

usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2+$4)}')
temp=$(sensors 2>/dev/null | awk '/Package id 0/ {gsub("\\+","",$4); gsub("°C","",$4); print int($4); exit}')
[ -z "$temp" ] && temp=$(sensors 2>/dev/null | awk '/Core 0/ {gsub("\\+","",$3); gsub("°C","",$3); print int($3); exit}')
[ -z "$temp" ] && temp="N/A"

# Per-core usage
cores=$(nproc)
core_info=$(top -bn1 | grep "^%Cpu" | head -1 | awk '{printf "User: %s%%  Sys: %s%%  Idle: %s%%", $2, $4, $8}')

# Freq
freq=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4; n++} END {printf "%.0f MHz", sum/n}')

# CPU model
model=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')

# Icon based on usage
if [ "$usage" -ge 80 ] 2>/dev/null; then
    icon="󰓅"
elif [ "$usage" -ge 50 ] 2>/dev/null; then
    icon="󰾆"
else
    icon="󰍛"
fi

tooltip="CPU: $model
Cores:      $cores
Usage:      $usage%
$core_info
Freq (avg): $freq
Temp:       ${temp}°C"

tooltip_json=$(printf '%s' "$tooltip" \
    | sed 's/\\/\\\\/g' \
    | sed 's/"/\\"/g' \
    | awk '{printf "%s\\n", $0}' \
    | sed 's/\\n$//')

printf '{"text": "%s %s%% %s°", "tooltip": "%s"}\n' \
    "$icon" "$usage" "$temp" "$tooltip_json"
