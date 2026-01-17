#!/bin/bash
# Power menu script

options="󰐥  Shutdown\n󰑓  Reboot\n󰒲  Suspend\n󰍃  Logout\n󰌾  Lock Screen\n⏾  Hibernate"


action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Menu" \
    --width 300 \
    --height 305 \
    --xoffset 1585  \
    --yoffset 20 \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --hide-search \
    --style ~/.config/wofi/style-menu.css 2>/dev/null)

case $action in
    "󰐥  Shutdown")
        systemctl poweroff
        ;;
    "󰑓  Reboot")
        systemctl reboot
        ;;
    "󰒲  Suspend")
        systemctl suspend
        ;;
    "󰍃  Logout")
        swaymsg exit
        ;;
    "󰌾  Lock Screen")
        swaylock \
        --color 1e1e2e \
        --inside-color 1e1e2e \
        --ring-color 89b4fa \
        --line-color 1e1e2e \
        --text-color cdd6f4 \
        --key-hl-color cba6f7 \
        --bs-hl-color f38ba8 \
        --separator-color 313244 \
        --inside-ver-color 94e2d5 \
        --ring-ver-color 94e2d5 \
        --text-ver-color cdd6f4 \
        --inside-wrong-color f38ba8 \
        --ring-wrong-color f38ba8 \
        --text-wrong-color cdd6f4 \
        --inside-clear-color 1e1e2e \
        --ring-clear-color 89b4fa \
        --text-clear-color cdd6f4 \
        --layout-bg-color 1e1e2e \
        --layout-text-color cdd6f4 \
        --layout-border-color 89b4fa;;

    "⏾  Hibernate")
        systemctl hibernate
        ;;
    *)
        exit 0
        ;;
esac
    *)
        exit 0
        ;;
esac
