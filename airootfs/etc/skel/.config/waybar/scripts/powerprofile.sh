#!/bin/bash

current=$(powerprofilesctl get)

case "$current" in
    performance)
        tooltip="Power Profile: Performance 🔥\nClick → Power Saver\n\nCPU: Boost enabled, max clocks\nPlatform: High performance mode"
        class="performance"
        ;;
    power-saver)
        tooltip="Power Profile: Power Saver 🌿\nClick → Balanced\n\nCPU: Reduced clocks, efficient\nPlatform: Low power mode"
        class="power-saver"
        ;;
    balanced|*)
        tooltip="Power Profile: Balanced ⚖️\nClick → Performance\n\nCPU: Dynamic scaling\nPlatform: Balanced mode"
        class="balanced"
        ;;
esac

# 󰮯 is the pac-man nerd font glyph
printf '{"text": "󰊠", "tooltip": "%s", "class": "%s"}\n' "$tooltip" "$class"
