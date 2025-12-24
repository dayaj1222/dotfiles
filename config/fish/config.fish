# ~/.config/fish/config.fish

# ENV variables
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PATH $HOME/.cargo/bin $PATH

if status is-interactive
    set fish_greeting ""
    if test -f ~/.config/fish/aliases.fish
        source ~/.config/fish/aliases.fish
    end
    if test -f ~/.config/fish/functions.fish
        source ~/.config/fish/functions.fish
    end
    if test -f ~/.config/fish/starship.fish
        source ~/.config/fish/starship.fish
    end
    if test -f ~/.config/fish/prompt.fish
        source ~/.config/fish/prompt.fish
    end
    source ~/.cache/wal/colors.fish
end


set -x STARSHIP_CONFIG ~/.cache/wal/starship.toml
# Created by `pipx` on 2025-12-14 16:30:29
set PATH $PATH /home/daya/.local/bin

