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
       swaylock -f \
        --screenshots \
        --clock \
        --indicator \
        --indicator-radius 100 \
        --indicator-thickness 7 \
        --effect-blur 15x7 \
        --effect-vignette 0.5:0.5 \
        --ring-color 444444 \
        --key-hl-color 777777 \
        --line-color 00000000 \
        --inside-color 000000aa \
        --separator-color 00000000 \
        --grace 0 \
        --fade-in 0;;

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
