#!/bin/bash
# screenshot.sh - Screenshot with swappy annotation
# Usage: screenshot.sh        (region select)
#        screenshot.sh -f     (full screen)

if ! command -v swappy >/dev/null 2>&1; then
    notify-send -u critical -t 3000 "Screenshot" "swappy not installed"
    exit 1
fi

if [[ "$1" == "-f" ]]; then
    grim - | swappy -f -
else
    region=$(slurp -d -b '#302d4180' -c '#96cdfb' -s '#57526840' -w 2) || exit 0
    grim -g "$region" - | swappy -f -
fi
