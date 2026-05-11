#!/bin/bash

options=" Shutdown\n Reboot\n Suspend\n󰍃 Logout\n󰗻 Lock Screen\n Hibernate"

action=$(echo -e "$options" | fuzzel --dmenu --hide-prompt --lines 6 --width 20 \
        --font="JetBrainsMono Nerd Font:size=10" \
    --anchor=top-right --x-margin=12 --y-margin=12)

case $action in
    " Shutdown")   systemctl poweroff ;;
    " Reboot")     systemctl reboot ;;
    " Suspend")    systemctl suspend ;;
    "󰍃 Logout")     hyprctl dispatch 'hl.dsp.exit()' ;;
    "󰗻 Lock Screen") hyprlock ;;
    " Hibernate")  systemctl hibernate ;;
    *) exit 0 ;;
esac
