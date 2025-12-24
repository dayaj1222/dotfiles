
#!/bin/bash

# Configuration
SCREENSHOT_DIR="$HOME/Pictures/screenshots"
BORDER_COLOR="#96cdfb"
BORDER_WIDTH=15

# Create screenshot directory if it doesn't exist
mkdir -p "$SCREENSHOT_DIR"

# Generate filename
filename="grim-$(date '+%Y-%m-%d-%H-%M-%S').png"
filepath="$SCREENSHOT_DIR/$filename"
temp_notification="/tmp/notification-screenshot.png"

# Check if swappy is installed
if ! command -v swappy >/dev/null 2>&1; then
    notify-send -u critical "❌ Error" "swappy not installed"
    exit 1
fi

# Take area screenshot and open in swappy for editing, save to
$SCREENSHOT_DIR
if grim -g "$(slurp -d -b '#302d4180' -c '#96cdfb' -s '#57526840' -w 2)" - |
swappy -f - -o "$filepath"; then
    notify-send "📸 swappy" "Screenshot edited and saved to $filepath"
else
    # Selection was cancelled or failed
    notify-send "📸 swappy" "Screenshot cancelled"
fi
