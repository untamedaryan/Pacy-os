#!/bin/bash

current=$(powerprofilesctl get)

case "$current" in
    balanced)     next="power-saver" ;;
    power-saver)  next="performance" ;;
    performance)  next="balanced" ;;
    *)            next="balanced" ;;
esac

powerprofilesctl set "$next"
