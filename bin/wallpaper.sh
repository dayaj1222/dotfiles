#!/bin/bash
# Wofi Wallpaper Selector with Pywal Integration
# Select and apply wallpapers using wofi, randomly, or test all wallpapers

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.config/sway/current_wallpaper_index"
LOG_FILE="$HOME/.cache/wallpaper_cleanup.log"

# Function to apply wallpaper
apply_wallpaper() {
    local wallpaper_path="$1"
    local wallpaper_name="$2"
    local selected_index="$3"
    
    # Apply wallpaper with wal using wal backend
    if uvx --from pywal16 wal -i "$wallpaper_path" -n --backend wal 2>/dev/null; then
        # Copy pywal colors to starship config if template exists
        if [ -f "$HOME/.cache/wal/starship.toml" ]; then
            cp "$HOME/.cache/wal/starship.toml" "$HOME/.config/starship.toml"
        fi
        
        # Save selected index
        echo "$selected_index" > "$STATE_FILE"
        notify-send -t 3000 "Wallpaper Changed" "Set to: $wallpaper_name" -i "$wallpaper_path"
        return 0
    else
        notify-send -t 1000 "Error" "Failed to set wallpaper" -u critical
        return 1
    fi
}

# Function to test and cleanup wallpapers
test_wallpapers() {
    local FAILED_WALLPAPERS=()
    local SUCCESSFUL_WALLPAPERS=()
    
    # Create log file directory if it doesn't exist
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Clear previous log
    echo "Wallpaper Cleanup - $(date)" > "$LOG_FILE"
    echo "================================" >> "$LOG_FILE"
    
    echo "Found ${#WALLPAPERS[@]} wallpapers to test" | tee -a "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    
    # Show initial notification
    notify-send "Wallpaper Cleanup" "Testing ${#WALLPAPERS[@]} wallpapers..." -t 3000
    
    # Test each wallpaper
    local CURRENT=0
    for wallpaper in "${WALLPAPERS[@]}"; do
        CURRENT=$((CURRENT + 1))
        local WALLPAPER_PATH="$WALLPAPER_DIR/$wallpaper"
        
        echo "[$CURRENT/${#WALLPAPERS[@]}] Testing: $wallpaper" | tee -a "$LOG_FILE"
        
        # Test with wal in dry-run mode (--preview flag) to avoid applying
        # This only generates the palette without applying it to the system
        if uvx --from pywal16 wal -i "$WALLPAPER_PATH" --preview --backend wal &>> "$LOG_FILE"; then
            echo "  ✓ SUCCESS" | tee -a "$LOG_FILE"
            SUCCESSFUL_WALLPAPERS+=("$wallpaper")
        else
            echo "  ✗ FAILED - Will be deleted" | tee -a "$LOG_FILE"
            FAILED_WALLPAPERS+=("$wallpaper")
            
            # Delete the failed wallpaper
            rm "$WALLPAPER_PATH"
            echo "  Deleted: $WALLPAPER_PATH" | tee -a "$LOG_FILE"
        fi
        
        echo "" >> "$LOG_FILE"
    done
    
    # Summary
    echo "================================" | tee -a "$LOG_FILE"
    echo "SUMMARY:" | tee -a "$LOG_FILE"
    echo "Total tested: ${#WALLPAPERS[@]}" | tee -a "$LOG_FILE"
    echo "Successful: ${#SUCCESSFUL_WALLPAPERS[@]}" | tee -a "$LOG_FILE"
    echo "Failed (deleted): ${#FAILED_WALLPAPERS[@]}" | tee -a "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    
    if [ ${#FAILED_WALLPAPERS[@]} -gt 0 ]; then
        echo "Deleted wallpapers:" | tee -a "$LOG_FILE"
        for wallpaper in "${FAILED_WALLPAPERS[@]}"; do
            echo "  - $wallpaper" | tee -a "$LOG_FILE"
        done
    fi
    
    # Final notification
    if [ ${#FAILED_WALLPAPERS[@]} -gt 0 ]; then
        notify-send "Cleanup Complete" "Removed ${#FAILED_WALLPAPERS[@]} incompatible wallpapers\nKept ${#SUCCESSFUL_WALLPAPERS[@]} working wallpapers" -t 5000
    else
        notify-send "Cleanup Complete" "All ${#SUCCESSFUL_WALLPAPERS[@]} wallpapers are compatible!" -t 5000
    fi
    
    echo "" | tee -a "$LOG_FILE"
    echo "Log saved to: $LOG_FILE" | tee -a "$LOG_FILE"
    
    exit 0
}

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

# Check for arguments
if [ "$1" = "-t" ] || [ "$1" = "--test" ]; then
    # Test mode - test all wallpapers and delete incompatible ones
    test_wallpapers
fi

if [ "$1" = "-r" ] || [ "$1" = "--random" ]; then
    # Random mode
    RANDOM_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
    SELECTED="${WALLPAPERS[$RANDOM_INDEX]}"
    SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"
    
    apply_wallpaper "$SELECTED_PATH" "$SELECTED" "$RANDOM_INDEX"
    exit $?
fi

# Interactive mode (default behavior)
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

# Apply the wallpaper
apply_wallpaper "$SELECTED_PATH" "$SELECTED" "$SELECTED_INDEX"
