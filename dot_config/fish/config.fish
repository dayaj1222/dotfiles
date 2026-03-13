# ── config.fish ─────────────────────────────────────────────
# conf.d/ files are auto-sourced; functions/ are auto-loaded.
# This file handles interactive-only startup.

if status is-interactive
    set -g fish_greeting ""
    source ~/.cache/wal/colors.fish

    if not set -q TMUX
        exec tmux
    end
end
