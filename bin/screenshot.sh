#!/bin/bash

# Configuration
SCREENSHOT_DIR="$HOME/Pictures/screenshots"
TEMP_DIR="/tmp"
BORDER_COLOR="#96cdfb"
BORDER_WIDTH=30

# Create screenshot directory if it doesn't exist
mkdir -p "$SCREENSHOT_DIR"

# Generate filename with timestamp
filename="grim-$(date '+%d-%m-%Y-%H-%M-%S').png"
filepath="$SCREENSHOT_DIR/$filename"
temp_notification="$TEMP_DIR/screenshot-notification.png"

# Take screenshot and save to clipboard + file
if grim - | tee "$filepath" | wl-copy; then
    # Create bordered version for notification (if imagemagick is available)
    if command -v magick >/dev/null 2>&1; then
        magick "$filepath" -bordercolor "$BORDER_COLOR" -border "$BORDER_WIDTH" "$temp_notification"
        notify-send -i "$temp_notification" "📸 Screenshot" "Saved as $filename"
        rm -f "$temp_notification"
    else
        notify-send "📸 Screenshot" "Saved as $filename"
    fi
else
    notify-send -u critical "❌ Screenshot Failed" "Could not capture screenshot"
    exit 1
fi
