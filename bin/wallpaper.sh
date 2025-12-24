#!/bin/bash
# Wofi Wallpaper Selector with Pywal Integration
# Select and apply wallpapers using wofi

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.config/sway/current_wallpaper_index"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory $WALLPAPER_DIR does not exist" -u critical
    exit 1
fi

# Create config directory if it doesn't exist
mkdir -p "$(dirname "$STATE_FILE")"

# Get list of image files
WALLPAPERS=()
cd "$WALLPAPER_DIR" || exit 1

for file in *; do
    if [ -f "$file" ]; then
        case "$file" in
            *.jpg|*.jpeg|*.png|*.bmp|*.gif|*.webp|*.JPG|*.JPEG|*.PNG|*.BMP|*.GIF|*.WEBP)
                WALLPAPERS+=("$file")
                ;;
        esac
    fi
done

# Check if any wallpapers found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Error" "No image files found in $WALLPAPER_DIR" -u critical
    exit 1
fi

# Sort wallpapers alphabetically
IFS=$'\n' WALLPAPERS=($(sort <<<"${WALLPAPERS[*]}"))
unset IFS

# Get current wallpaper (if exists)
CURRENT_INDEX=0
CURRENT_WALLPAPER=""
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
    if [ "$CURRENT_INDEX" -lt ${#WALLPAPERS[@]} ]; then
        CURRENT_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"
    fi
fi

# Create wofi menu with current wallpaper highlighted
SELECTED=$(printf '%s\n' "${WALLPAPERS[@]}" | \
    wofi --dmenu \
    --prompt "Select Wallpaper" \
    --width 600 \
    --height 400 \
    --insensitive \
    --cache-file=/dev/null)

# Exit if no selection
if [ -z "$SELECTED" ]; then
    exit 0
fi

# Find index of selected wallpaper
SELECTED_INDEX=0
for i in "${!WALLPAPERS[@]}"; do
    if [ "${WALLPAPERS[$i]}" = "$SELECTED" ]; then
        SELECTED_INDEX=$i
        break
    fi
done

# Full path to selected wallpaper
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"

# Apply wallpaper with wal using colorthief backend
if wal -i "$SELECTED_PATH" -n --backend colorthief 2>/dev/null; then
    # Copy pywal colors to starship config if template exists
    if [ -f "$HOME/.cache/wal/starship.toml" ]; then
        cp "$HOME/.cache/wal/starship.toml" "$HOME/.config/starship.toml"
    fi
    
    # Save selected index
    echo "$SELECTED_INDEX" > "$STATE_FILE"
    
    notify-send "Wallpaper Changed" "Set to: $SELECTED" -i "$SELECTED_PATH"
else
    notify-send "Error" "Failed to set wallpaper" -u critical
fi
