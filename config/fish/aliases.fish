# ~/.config/fish/aliases.fish

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias fe='ranger'

# Listing
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Package management
alias update='pkg update && pkg upgrade -y'
alias install='pkg install -y'
alias search='pkg search'

# Quick editors
alias vi='nvim'
alias cls='clear'

# Networking
alias myip='curl ifconfig.me'

# Other small helpers
alias h='history'
alias j='jobs'

# Downloading
alias dl='aria2c --conf-path ~/.config/aria2/aria2.conf'
alias dls='aria2c --conf-path ~/.config/aria2/aria2.conf --bt-sequential-unwanted-piece-priorities=true'
