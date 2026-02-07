# ~/.config/fish/config.fish

# ENV variables
set -x EDITOR nvim
set -x VISUAL nvim
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.npm/bin $PATH

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

    if not set -q TMUX
        exec tmux 
    end
end


set -x STARSHIP_CONFIG ~/.cache/wal/starship.toml

