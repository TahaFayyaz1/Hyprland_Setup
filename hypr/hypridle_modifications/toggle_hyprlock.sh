#!/usr/bin/env bash

LOCK_FILE="$HOME/.cache/hypridle_lock"

# toggle
lock_enabled=1
if [[ -f "$LOCK_FILE" ]]; then
  lock_enabled=$(<"$LOCK_FILE")
fi
lock_enabled=$((1 - lock_enabled))
echo "$lock_enabled" > "$LOCK_FILE"

# restart hypridle with current mode
~/.config/hypr/hypridle_modifications/toggle_hypridle.sh >/dev/null 2>&1

# notify
if (( lock_enabled == 1 )); then
  notify-send "hyprlock" "Lock enabled"
else
  notify-send "hyprlock" "Lock disabled"
fi

