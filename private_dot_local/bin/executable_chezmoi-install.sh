#!/usr/bin/env bash
# Dotfiles Setup: Install packages + apply chezmoi configs
set -euo pipefail

# Packages to install with paru
apps=(
  btop zen-browser-bin kitty mako nvim ripgrep p7zip
  sway swaylock-effects waybar fuzzel python uv mpv yt-dlp
  satty xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  slurp imagemagick grim ttf-jetbrains-mono-nerd power-profiles-daemon
  brightnessctl pipewire pipewire-pulse wireplumber
  pavucontrol noto-fonts noto-fonts-emoji fish starship libnotify yazi
  unzip lazygit fd fzf swaybg swayimg swayidle swaylock-effects wl-clipboard cliphist python-gobject catppuccin-gtk-theme-mocha papirus-icon-theme
)

# Packages to install with uv
uv_apps=(
  pywal16 pywalfox
)

echo "========== Installing Packages =========="

# Install with paru
if command -v paru &>/dev/null; then
  echo "Installing packages with paru..."
  paru -S --needed --noconfirm "${apps[@]}"
else
  echo "WARNING: paru not found (skipping package installation)"
fi

# Install with uv
if command -v uv &>/dev/null; then
  echo ""
  echo "Installing packages with uv..."
  for pkg in "${uv_apps[@]}"; do
    echo "Installing $pkg..."
    uv tool install "$pkg" || echo "WARNING: Failed to install $pkg"
  done
else
  echo "WARNING: uv not found (skipping uv package installation)"
fi

echo ""
echo "========== Applying Chezmoi Configs =========="

# Initialize and apply chezmoi
if command -v chezmoi &>/dev/null; then
  echo "Applying chezmoi..."
  chezmoi init --apply
  chezmoi apply
  echo "✓ Configs applied!"
else
  echo "ERROR: chezmoi not found. Install with: sh -c \"\$(curl -fsLS get.chezmoi.io)\""
  exit 1
fi

echo ""
echo "========== Setup Complete =========="
echo "Your system is now configured with all apps and dotfiles!"
