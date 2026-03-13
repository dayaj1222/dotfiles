#!/bin/bash
# screenshot.sh - Screenshot with satty annotation
# Usage: screenshot.sh        (region select)
#        screenshot.sh -f     (full screen)

SCREENSHOT_DIR="$HOME/Pictures/screenshots"
mkdir -p "$SCREENSHOT_DIR"

filename="grim-$(date '+%Y-%m-%d-%H-%M-%S').png"
filepath="$SCREENSHOT_DIR/$filename"

if ! command -v satty >/dev/null 2>&1; then
    notify-send -u critical -t 3000 "Screenshot" "satty not installed"
    exit 1
fi

if [[ "$1" == "-f" ]]; then
    grim - | satty --filename - --output-filename "$filepath"
else
    region=$(slurp -d -b '#302d4180' -c '#96cdfb' -s '#57526840' -w 2) || exit 0
    grim -g "$region" - | satty --filename - --output-filename "$filepath"
fi
