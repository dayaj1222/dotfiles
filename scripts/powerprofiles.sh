#!/bin/bash

current=$(powerprofilesctl get)
case $current in
    performance) icon="󱐋" label="Performance" ;;
    balanced)    icon="󰾅" label="Balanced"    ;;
    power-saver) icon="󰌪" label="Power Saver" ;;
    *)           icon="󰾅" label="Balanced"    ;;
esac

# Called with no args: output status for waybar
if [ $# -eq 0 ]; then
    echo "{\"text\": \"$icon\", \"tooltip\": \"$label\", \"class\": \"$current\"}"
    exit 0
fi

perf="󱐋  Performance"
bal="󰾅  Balanced"
saver="󰌪  Power Saver"

case $current in
    performance) perf="●  󱐋  Performance" ;;
    balanced)    bal="●  󰾅  Balanced"    ;;
    power-saver) saver="●  󰌪  Power Saver" ;;
esac

options="$perf\n$bal\n$saver"

action=$(echo -e "$options" | fuzzel --dmenu --hide-prompt --lines 3 --width 22 \
        --font="JetBrainsMono Nerd Font:size=10" \
    --anchor=top-right --x-margin=200 --y-margin=12)

case $action in
    *Performance*)
        powerprofilesctl set performance
        notify-send -t 3000 "Power Profile" "Performance" ;;
    *Balanced*)
        powerprofilesctl set balanced
        notify-send -t 3000 "Power Profile" "Balanced" ;;
    *Power*Saver*)
        powerprofilesctl set power-saver
        notify-send -t 3000 "Power Profile" "Power Saver" ;;
    *) exit 0 ;;
esac
