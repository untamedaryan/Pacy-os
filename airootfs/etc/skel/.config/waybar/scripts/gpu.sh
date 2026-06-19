#!/bin/bash

gpu_data=$(nvidia-smi --query-gpu=name,utilization.gpu,temperature.gpu,memory.used,memory.total,power.draw,power.limit,fan.speed,clocks.gr,clocks.mem \
    --format=csv,noheader,nounits 2>/dev/null)

if [ -z "$gpu_data" ]; then
    echo '{"text": "󰢮 N/A", "tooltip": "No NVIDIA GPU detected"}'
    exit 0
fi

IFS=',' read -r name util temp mem_used mem_total power_draw power_limit fan_speed clock_gr clock_mem <<< "$gpu_data"
# trim whitespace
trim() { echo "$1" | sed 's/^ *//;s/ *$//'; }
name=$(trim "$name"); util=$(trim "$util"); temp=$(trim "$temp")
mem_used=$(trim "$mem_used"); mem_total=$(trim "$mem_total")
power_draw=$(trim "$power_draw"); power_limit=$(trim "$power_limit")
fan_speed=$(trim "$fan_speed"); clock_gr=$(trim "$clock_gr"); clock_mem=$(trim "$clock_mem")

mem_pct=$(awk "BEGIN {printf \"%d\", ($mem_used/$mem_total)*100}")

tooltip="GPU: $name
Usage:       ${util}%
Temp:        ${temp}°C
Memory:      ${mem_used} MiB / ${mem_total} MiB  (${mem_pct}%)
Power:       ${power_draw}W / ${power_limit}W
Fan:         ${fan_speed}%
Core clock:  ${clock_gr} MHz
Mem clock:   ${clock_mem} MHz"

tooltip_json=$(printf '%s' "$tooltip" \
    | sed 's/\\/\\\\/g' \
    | sed 's/"/\\"/g' \
    | awk '{printf "%s\\n", $0}' \
    | sed 's/\\n$//')

printf '{"text": "󰢮 %s%% %s°", "tooltip": "%s"}\n' \
    "$util" "$temp" "$tooltip_json"
