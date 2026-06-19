#!/bin/bash

# Find battery and adapter
BAT=$(ls /sys/class/power_supply/ | grep -i "BAT" | head -1)
ADP=$(ls /sys/class/power_supply/ | grep -iE "^AC$|^ADP|^ACAD" | head -1)

if [ -z "$BAT" ]; then
    echo '{"text": "󰚥 N/A", "tooltip": "No battery found", "class": "none"}'
    exit 0
fi

BAT_PATH="/sys/class/power_supply/$BAT"

capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo "?")
status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")
manufacturer=$(cat "$BAT_PATH/manufacturer" 2>/dev/null || echo "Unknown")
model=$(cat "$BAT_PATH/model_name" 2>/dev/null || echo "Unknown")
technology=$(cat "$BAT_PATH/technology" 2>/dev/null || echo "Unknown")
cycle_count=$(cat "$BAT_PATH/cycle_count" 2>/dev/null || echo "N/A")

# Energy values (µWh)
energy_now=$(cat "$BAT_PATH/energy_now" 2>/dev/null)
energy_full=$(cat "$BAT_PATH/energy_full" 2>/dev/null)
energy_full_design=$(cat "$BAT_PATH/energy_full_design" 2>/dev/null)
power_now=$(cat "$BAT_PATH/power_now" 2>/dev/null)

# Charge values fallback (µAh)
charge_now=$(cat "$BAT_PATH/charge_now" 2>/dev/null)
charge_full=$(cat "$BAT_PATH/charge_full" 2>/dev/null)
charge_full_design=$(cat "$BAT_PATH/charge_full_design" 2>/dev/null)
current_now=$(cat "$BAT_PATH/current_now" 2>/dev/null)
voltage_now=$(cat "$BAT_PATH/voltage_now" 2>/dev/null)

# Icon based on status and capacity
if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    icon="󰂄"
elif [ "$capacity" -le 10 ] 2>/dev/null; then
    icon="󰂄"
elif [ "$capacity" -le 30 ] 2>/dev/null; then
    icon="󰂄"
elif [ "$capacity" -le 60 ] 2>/dev/null; then
    icon="󰂄"
elif [ "$capacity" -le 85 ] 2>/dev/null; then
    icon="󰂄"
else
    icon="󰂄"
fi

# Time remaining calculation
time_str="N/A"
minutes=""
if [ -n "$energy_now" ] && [ -n "$power_now" ] && [ "$power_now" -gt 0 ] 2>/dev/null; then
    if [ "$status" = "Discharging" ]; then
        minutes=$(( energy_now * 60 / power_now ))
    elif [ "$status" = "Charging" ] && [ -n "$energy_full" ]; then
        minutes=$(( (energy_full - energy_now) * 60 / power_now ))
    fi
elif [ -n "$charge_now" ] && [ -n "$current_now" ] && [ "$current_now" -gt 0 ] 2>/dev/null; then
    if [ "$status" = "Discharging" ]; then
        minutes=$(( charge_now * 60 / current_now ))
    elif [ "$status" = "Charging" ] && [ -n "$charge_full" ]; then
        minutes=$(( (charge_full - charge_now) * 60 / current_now ))
    fi
fi
if [ -n "$minutes" ] && [ "$minutes" -gt 0 ] 2>/dev/null; then
    hours=$(( minutes / 60 ))
    mins=$(( minutes % 60 ))
    time_str="${hours}h ${mins}m"
fi

# Power draw
power_str="N/A"
if [ -n "$power_now" ] && [ "$power_now" -gt 0 ] 2>/dev/null; then
    power_str=$(awk "BEGIN {printf \"%.2f W\", $power_now/1000000}")
elif [ -n "$current_now" ] && [ -n "$voltage_now" ] && [ "$current_now" -gt 0 ] 2>/dev/null; then
    power_str=$(awk "BEGIN {printf \"%.2f W\", ($current_now/1000000)*($voltage_now/1000000)}")
fi

# Battery health
health_str="N/A"
if [ -n "$energy_full" ] && [ -n "$energy_full_design" ] && [ "$energy_full_design" -gt 0 ] 2>/dev/null; then
    health_str=$(awk "BEGIN {printf \"%.1f%%\", ($energy_full/$energy_full_design)*100}")
elif [ -n "$charge_full" ] && [ -n "$charge_full_design" ] && [ "$charge_full_design" -gt 0 ] 2>/dev/null; then
    health_str=$(awk "BEGIN {printf \"%.1f%%\", ($charge_full/$charge_full_design)*100}")
fi

# Adapter info
adapter_str="Not detected"
if [ -n "$ADP" ]; then
    adp_online=$(cat "/sys/class/power_supply/$ADP/online" 2>/dev/null)
    adp_type=$(cat "/sys/class/power_supply/$ADP/type" 2>/dev/null || echo "AC")
    if [ "$adp_online" = "1" ]; then
        adapter_str="$ADP ($adp_type) — Connected"
    else
        adapter_str="$ADP ($adp_type) — Disconnected"
    fi
fi

# Status with time label
if [ "$status" = "Charging" ]; then
    status_label="Charging ↑  (full in: $time_str)"
elif [ "$status" = "Discharging" ]; then
    status_label="Discharging ↓  (remaining: $time_str)"
else
    status_label="$status"
fi

# CSS class
class="normal"
[ "$capacity" -le 30 ] 2>/dev/null && class="warning"
[ "$capacity" -le 15 ] 2>/dev/null && class="critical"
[ "$status" = "Charging" ] && class="charging"
[ "$status" = "Full" ] && class="full"

tooltip="Battery: $BAT
Status:       $status_label
Capacity:     $capacity%
Health:       $health_str  (Cycles: $cycle_count)
Power draw:   $power_str

Manufacturer: $manufacturer
Model:        $model
Technology:   $technology

Adapter:      $adapter_str"

# Safely escape tooltip for JSON
tooltip_json=$(printf '%s' "$tooltip" \
    | sed 's/\\/\\\\/g' \
    | sed 's/"/\\"/g' \
    | awk '{printf "%s\\n", $0}' \
    | sed 's/\\n$//')

printf '{"text": "%s %s%%", "tooltip": "%s", "class": "%s"}\n' \
    "$icon" "$capacity" "$tooltip_json" "$class"
