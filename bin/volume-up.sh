#!/bin/sh

MAX_RIGHT=60
MAX_LEFT=150
INCREMENT=5

# get current left and right volumes
volumes=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -m1 -oP '\d+%' | sed 's/%//g')
LEFT=$(echo $volumes | awk '{print $1}')
RIGHT=$(echo $volumes | awk '{print $2}')

# unmute
pactl set-sink-mute @DEFAULT_SINK@ false

# increase
NEW_LEFT=$((LEFT + INCREMENT))
NEW_RIGHT=$((RIGHT + INCREMENT))

# clamp
[ $NEW_LEFT -gt $MAX_LEFT ] && NEW_LEFT=$MAX_LEFT
[ $NEW_RIGHT -gt $MAX_RIGHT ] && NEW_RIGHT=$MAX_RIGHT

# set volume
pactl set-sink-volume @DEFAULT_SINK@ ${NEW_LEFT}% ${NEW_RIGHT}%


