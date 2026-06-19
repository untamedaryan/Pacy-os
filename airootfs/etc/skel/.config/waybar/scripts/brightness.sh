#!/bin/bash

brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

echo "󰃟 ${brightness}"
