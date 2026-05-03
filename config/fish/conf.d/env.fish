# ── env.fish ────────────────────────────────────────────────
# Environment variables (set globally, available everywhere)

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SDL_VIDEODRIVER wayland
set -gx STARSHIP_CONFIG ~/.cache/wal/starship.toml
# env.fish
set -gx ADW_DEBUG_COLOR_SCHEME prefer-dark
set -gx GTK_THEME catppuccin-mocha-blue-standard+default:dark

# Hyprland instance signature fix
if not set -q HYPRLAND_INSTANCE_SIGNATURE
    and test -d /run/user/(id -u)/hypr
    set -gx HYPRLAND_INSTANCE_SIGNATURE (ls /run/user/(id -u)/hypr | sort | tail -1)
end
