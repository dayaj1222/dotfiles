# ── aliases.fish ────────────────────────────────────────────

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# File management
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'
alias fe='ranger'

# Editor
alias vi='nvim'
alias cls='clear'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Package management (pacman)
alias update='sudo pacman -Syuu'
alias install='sudo pacman -S'
alias search='pacman -Ss'

# Network
alias myip='curl ifconfig.me'

# Downloads (aria2c)
alias dl='aria2c --conf-path ~/.config/aria2/aria2.conf'
alias dls='aria2c --conf-path ~/.config/aria2/aria2.conf --bt-sequential-unwanted-piece-priorities=true'

# Misc
alias h='history'
alias j='jobs'
