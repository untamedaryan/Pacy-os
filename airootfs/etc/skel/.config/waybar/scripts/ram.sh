#!/bin/bash

eval $(free -b | awk '/Mem:/ {
    printf "total=%s used=%s free=%s available=%s cached=%s buffers=%s", $2, $3, $4, $7, $6, $5
}')

to_gb() { awk "BEGIN {printf \"%.1f GiB\", $1/1073741824}"; }

used_h=$(to_gb $used)
total_h=$(to_gb $total)
free_h=$(to_gb $free)
avail_h=$(to_gb $available)
cached_h=$(to_gb $cached)
buffers_h=$(to_gb $buffers)
pct=$(awk "BEGIN {printf \"%d\", ($used/$total)*100}")

# Swap
eval $(free -b | awk '/Swap:/ {printf "swap_total=%s swap_used=%s swap_free=%s", $2, $3, $4}')
swap_used_h=$(to_gb $swap_used)
swap_total_h=$(to_gb $swap_total)

tooltip="RAM
Used:      $used_h / $total_h  ($pct%)
Free:      $free_h
Available: $avail_h
Cached:    $cached_h
Buffers:   $buffers_h

Swap
Used:  $swap_used_h / $swap_total_h"

tooltip_json=$(printf '%s' "$tooltip" \
    | sed 's/\\/\\\\/g' \
    | sed 's/"/\\"/g' \
    | awk '{printf "%s\\n", $0}' \
    | sed 's/\\n$//')

printf '{"text": "󰘚 %s%% %s", "tooltip": "%s"}\n' \
    "$pct" "$used_h" "$tooltip_json"
