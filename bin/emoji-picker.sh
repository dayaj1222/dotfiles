#!/bin/bash
# Emoji Picker for Sway with wofi
EMOJI_FILE="$HOME/dotfiles/bin/emojis.txt"
RECENT_FILE="$HOME/.cache/recent-emojis.txt"

# Add emoji to recent list
add_recent() {
    local emoji_line="$1"
    mkdir -p "$(dirname "$RECENT_FILE")"
    
    if [ -f "$RECENT_FILE" ]; then
        grep -Fxv "$emoji_line" "$RECENT_FILE" > "${RECENT_FILE}.tmp" 2>/dev/null || true
        mv "${RECENT_FILE}.tmp" "$RECENT_FILE"
    fi
    
    echo "$emoji_line" | cat - "$RECENT_FILE" 2>/dev/null | head -20 > "${RECENT_FILE}.tmp"
    mv "${RECENT_FILE}.tmp" "$RECENT_FILE"
}

# Main function
main() {
    # Build the list
    if [ -f "$RECENT_FILE" ] && [ -s "$RECENT_FILE" ]; then
        list=$(cat "$RECENT_FILE"; echo "---"; cat "$EMOJI_FILE")
    else
        list=$(cat "$EMOJI_FILE")
    fi
    
    # Show in wofi
    selection=$(echo "$list" | wofi --dmenu -i -p "Emoji")
    
    # Skip separator
    if [ "$selection" = "---" ] || [ -z "$selection" ]; then
        exit 0
    fi
    
    # Extract just the emoji (first field)
    emoji=$(echo "$selection" | awk '{print $1}')
    
    # Copy to clipboard
    echo -n "$emoji" | wl-copy
    
    # Add to recent
    add_recent "$selection"
}

main
