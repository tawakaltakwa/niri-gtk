#!/usr/bin/env bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 1; done

waybar -c ~/.config/niri/waybar/config.jsonc -s ~/.config/niri/waybar/style.css &
