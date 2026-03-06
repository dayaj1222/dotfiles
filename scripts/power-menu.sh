#!/bin/bash

options=" Shutdown\n Reboot\n Suspend\n󰍃 Logout\n󰗻 Lock Screen\n Hibernate"

action=$(echo -e "$options" | fuzzel --dmenu --hide-prompt --lines 6 --width 20 \
        --font="JetBrainsMono Nerd Font:size=10" \
    --anchor=top-right --x-margin=12 --y-margin=12)

case $action in
    " Shutdown")   systemctl poweroff ;;
    " Reboot")     systemctl reboot ;;
    " Suspend")    systemctl suspend ;;
    "󰍃 Logout")     swaymsg exit ;;
    "󰗻 Lock Screen")
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
            --fade-in 0 ;;
    " Hibernate")  systemctl hibernate ;;
    *) exit 0 ;;
esac
