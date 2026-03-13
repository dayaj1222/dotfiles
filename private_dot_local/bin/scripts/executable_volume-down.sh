#!/bin/sh
MAX_RIGHT=60
INCREMENT=5

# get current left and right volumes
volumes=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | sed 's/%//g')
LEFT=$(echo $volumes | awk '{print $1}')
RIGHT=$(echo $volumes | awk '{print $2}')

# calculate tentative new left
NEW_LEFT=$((LEFT - INCREMENT))
[ $NEW_LEFT -lt 0 ] && NEW_LEFT=0

# right only decreases if left goes below right
if [ $NEW_LEFT -lt $RIGHT ]; then
    NEW_RIGHT=$((RIGHT - INCREMENT))
    [ $NEW_RIGHT -lt 0 ] && NEW_RIGHT=0
else
    NEW_RIGHT=$RIGHT
fi

# apply volume
pactl set-sink-volume @DEFAULT_SINK@ ${NEW_LEFT}% ${NEW_RIGHT}%


