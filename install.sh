#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Dotfiles Setup: Install packages and symlink configurations
# Automatically symlinks ALL directories found in config/
# -----------------------------------------------------------------------------
set -euo pipefail

# ----- Configuration -----
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_CONFIG="$DOTFILES_DIR/config"
DOTFILES_SCRIPTS="$DOTFILES_DIR/scripts"
DOTFILES_WALLPAPER="$DOTFILES_DIR/wallpapers"

CONFIG_DIR="$HOME/.config"
WALLPAPER_TARGET="$HOME/Pictures/wallpapers"

# Packages to install with paru (edit as needed)
apps=(
  btop zen-browser-bin kitty mako nvim ripgrep p7zip
  sway swaylock-effects waybar fuzzel python uv mpv yt-dlp
  satty xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  slurp imagemagick grim ttf-jetbrains-mono-nerd power-profiles-daemon
  brightnessctl pipewire pipewire-pulse wireplumber
  pavucontrol noto-fonts-emoji fish starship libnotify yazi
  nodejs npm unzip lazygit fd swaybg swayimg swayidle swaylock-effects wl-clipboard cliphist tree-sitter-cli
  python-gobject catppuccin-gtk-theme-mocha papirus-icon-theme
)

# Packages to install with uv (edit as needed)
uv_apps=(
  pywal16 pywalfox
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
    echo "WARNING: Source missing: $src (skipping)"
    return 0
  fi

  # Check if symlink already points to correct location
  if [[ -L "$tgt" ]]; then
    local current=$(readlink -f "$tgt" 2>/dev/null || echo "")
    local desired=$(readlink -f "$src")
    if [[ "$current" == "$desired" ]]; then
      echo "Already linked: $tgt"
      return 0
    fi
  fi

  # Backup existing target
  if [[ -e "$tgt" || -L "$tgt" ]]; then
    mkdir -p "$backup_dir"
    echo "Backing up: $tgt"
    mv "$tgt" "$backup_dir/" || { echo "ERROR: Failed to backup $tgt"; exit 1; }
  fi

  # Create symlink
  mkdir -p "$(dirname "$tgt")"
  ln -s "$src" "$tgt"
  echo "Linked: $tgt → $src"
}

# ----- Install packages with paru -----
if command -v paru &>/dev/null; then
  echo "Installing packages with paru..."
  paru -S --needed --noconfirm "${apps[@]}"
else
  echo "WARNING: paru not found (skipping package installation)"
fi

# ----- Install packages with uv -----
if command -v uv &>/dev/null; then
  echo ""
  echo "Installing packages with uv..."
  for pkg in "${uv_apps[@]}"; do
    echo "Installing $pkg..."
    uv tool install "$pkg" || echo "WARNING: Failed to install $pkg"
  done
else
  echo ""
  echo "WARNING: uv not found (skipping uv package installation)"
fi

# ----- Symlink all config directories automatically -----
echo ""
echo "Setting up config directories..."
mkdir -p "$CONFIG_DIR"

if [[ -d "$DOTFILES_CONFIG" ]]; then
  for dir in "$DOTFILES_CONFIG"/*; do
    # Skip if not a directory
    [[ -d "$dir" ]] || continue
    
    dirname=$(basename "$dir")
    link_safe "$dir" "$CONFIG_DIR/$dirname"
  done
else
  echo "WARNING: Config directory not found: $DOTFILES_CONFIG"
fi

# ----- Scripts already on PATH via fish conf.d/paths.fish -----
# $DOTFILES_SCRIPTS is added to PATH directly — no symlink needed

# ----- Symlink wallpapers -----
echo ""
echo "Setting up wallpapers..."
mkdir -p "$(dirname "$WALLPAPER_TARGET")"
link_safe "$DOTFILES_WALLPAPER" "$WALLPAPER_TARGET"

# ----- Completion -----
echo ""
echo "Setup complete!"
if [[ -d "$backup_dir" ]]; then
  echo "Backups saved to: $backup_dir"
  echo "   Remove after verification: rm -rf $backup_dir"
fi

