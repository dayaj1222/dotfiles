#!/bin/bash

# Pick a single pixel using slurp, capture with grim, extract color
COLOR=$(grim -g "$(slurp -p)" -t ppm - | magick - -format '%[pixel:p{0,0}]' txt:- | grep -oP '#[0-9A-Fa-f]{6}')

# Copy to clipboard
echo -n "$COLOR" | wl-copy

# Optional: show notification
notify-send "Color Copied" "$COLOR" -t 2000

echo "$COLOR"
