#!/bin/bash
# Power profile menu script with indicator

# Get current mode
current=$(powerprofilesctl get)

# Define options with icons
options="󱊦  Performance
  Balanced
󱈏  Power Saver"

# Add styled checkmark and bold text to current profile
if [[ "$current" == "performance" ]]; then
    options=$(echo "$options" | sed "s/\(󱊦  Performance\)/<span foreground='#000000'><\/span> <b>\1<\/b>/")
elif [[ "$current" == "balanced" ]]; then
    options=$(echo "$options" | sed "s/\(  Balanced\)/<span foreground='#000000'><\/span> <b>\1<\/b>/")
elif [[ "$current" == "power-saver" ]]; then
    options=$(echo "$options" | sed "s/\(󱈏  Power Saver\)/<span foreground='#000000'><\/span> <b>\1<\/b>/")
fi

# Show menu
action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Profile" \
    --width 300 \
    --height 150 \
    --xoffset 1370  \
    --yoffset 20 \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --hide-search \
    --style ~/.config/wofi/style.css 2>/dev/null)

# Strip markup and checkmark
action=$(echo "$action" | sed 's/<[^>]*>//g' | sed 's/󰍕 ^//')

case $action in
    "󱊦  Performance")
        powerprofilesctl set performance
        notify-send "Power Profile" "Switched to Performance mode" -t 2000
        ;;
    "  Balanced")
        powerprofilesctl set balanced
        notify-send "Power Profile" "Switched to Balanced mode" -t 2000
        ;;
    "󱈏  Power Saver")
        powerprofilesctl set power-saver
        notify-send "Power Profile" "Switched to Power Saver mode" -t 2000
        ;;
    *)
        exit 0
        ;;
esac
