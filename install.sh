#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Dotfiles Setup: Install packages and symlink configurations
# Automatically symlinks ALL directories found in config/
# -----------------------------------------------------------------------------
set -euo pipefail

# ----- Configuration -----
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_CONFIG="$DOTFILES_DIR/config"
DOTFILES_BIN="$DOTFILES_DIR/bin"
DOTFILES_WALLPAPER="$DOTFILES_DIR/wallpaper"

CONFIG_DIR="$HOME/.config"
BIN_TARGET="$HOME/bin"
WALLPAPER_TARGET="$HOME/Pictures/wallpapers"

# Packages to install (edit as needed)
apps=(
  btop firefox cliphist imv kitty mako nvim ripgrep
  sway swaylock-effects waybar wofi
  slurp imagemagick grim tff-jetbrains-mono-nerd
  brightnessctl pipewire pipewire-pulse wireplumber
  pavucontrol noto-fonts-emoji
  nodejs npm unzip lazygit fd swaybg swayidle swaylock-effects fish
)

# ----- Setup -----
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="$HOME/dotfiles_backup_$timestamp"

# Create symlink with backup of existing target
link_safe() {
  local src="$1"
  local tgt="$2"

  # Verify source exists
  if [[ ! -e "$src" ]]; then
    echo "⚠️  Source missing: $src (skipping)"
    return 0
  fi

  # Check if symlink already points to correct location
  if [[ -L "$tgt" ]]; then
    local current=$(readlink -f "$tgt" 2>/dev/null || echo "")
    local desired=$(readlink -f "$src")
    if [[ "$current" == "$desired" ]]; then
      echo "✓  Already linked: $tgt"
      return 0
    fi
  fi

  # Backup existing target
  if [[ -e "$tgt" || -L "$tgt" ]]; then
    mkdir -p "$backup_dir"
    echo "📦 Backing up: $tgt"
    mv "$tgt" "$backup_dir/" || { echo "❌ Failed to backup $tgt"; exit 1; }
  fi

  # Create symlink
  mkdir -p "$(dirname "$tgt")"
  ln -s "$src" "$tgt"
  echo "🔗 Linked: $tgt → $src"
}

# ----- Install packages -----
if command -v yay &>/dev/null; then
  echo "📦 Installing packages..."
  yay -S --needed --noconfirm "${apps[@]}"
else
  echo "⚠️  yay not found (skipping package installation)"
fi

# ----- Symlink all config directories automatically -----
echo ""
echo "🔧 Setting up config directories..."
mkdir -p "$CONFIG_DIR"

if [[ -d "$DOTFILES_CONFIG" ]]; then
  for dir in "$DOTFILES_CONFIG"/*; do
    # Skip if not a directory
    [[ -d "$dir" ]] || continue
    
    dirname=$(basename "$dir")
    link_safe "$dir" "$CONFIG_DIR/$dirname"
  done
else
  echo "⚠️  Config directory not found: $DOTFILES_CONFIG"
fi

# ----- Symlink bin directory -----
echo ""
echo "🔧 Setting up bin directory..."
link_safe "$DOTFILES_BIN" "$BIN_TARGET"

# ----- Symlink wallpapers -----
echo ""
echo "🖼️  Setting up wallpapers..."
mkdir -p "$(dirname "$WALLPAPER_TARGET")"
link_safe "$DOTFILES_WALLPAPER" "$WALLPAPER_TARGET"

# ----- Completion -----
echo ""
echo "✅ Setup complete!"
if [[ -d "$backup_dir" ]]; then
  echo "📦 Backups saved to: $backup_dir"
  echo "   Remove after verification: rm -rf $backup_dir"
fi
