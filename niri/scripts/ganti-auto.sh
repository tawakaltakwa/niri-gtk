#!/bin/bash

# Waktu interval (dalam detik) - 5 menit = 300 detik
INTERVAL=300

# Loop tak terbatas
while true; do
    bash "$HOME/.config/niri/scripts/change-wallpaper.sh"
    sleep $INTERVAL
done
