#!/bin/bash
# ~/.local/bin/caffeine-toggle.sh

PIDFILE="/tmp/caffeine.pid"

toggle() {
    if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
        # Kill existing caffeine process
        kill $(cat "$PIDFILE") 2>/dev/null
        rm "$PIDFILE"
    else
        # Start caffeine mode
        systemd-inhibit --what=idle:sleep:handle-lid-switch \
            --who="Caffeine" \
            --why="User requested" \
            sleep infinity &
        echo $! > "$PIDFILE"
    fi
}

status() {
    if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
        echo '{"text":"󰅶","class":"on","tooltip":"Caffeine: ON"}'
    else
        echo '{"text":"󰾪","class":"off","tooltip":"Caffeine: OFF"}'
    fi
}

case "$1" in
    toggle)
        toggle
        ;;
    *)
        status
        ;;
esac
