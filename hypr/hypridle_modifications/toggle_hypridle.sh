#!/usr/bin/env bash

# ─── CONFIG ─────────────────────────────────────────────────
MODE_FILE="$HOME/.cache/hypridle_mode"
LOCK_FILE="$HOME/.cache/hypridle_lock"
HYPRIDLE_CONF="$HOME/.cache/hypridle_temp.conf"
TIMEOUTS=(180 600 1800)
MODES_COUNT=$(( ${#TIMEOUTS[@]} + 1 ))
# ────────────────────────────────────────────────────────────

# Read current mode
old_mode=0
if [[ -f "$MODE_FILE" ]]; then
  old_mode=$(<"$MODE_FILE")
  [[ "$old_mode" =~ ^[0-9]+$ ]] || old_mode=$(( MODES_COUNT - 1 ))
else
  old_mode=$(( MODES_COUNT - 1 ))
fi

# Read lock setting
lock_enabled=1
if [[ -f "$LOCK_FILE" ]]; then
  lock_enabled=$(<"$LOCK_FILE")
  [[ "$lock_enabled" =~ ^[01]$ ]] || lock_enabled=1
fi

# Advance to next mode
new_mode=$(( (old_mode + 1) % MODES_COUNT ))
echo "$new_mode" > "$MODE_FILE"

# Kill current hypridle
pkill hypridle

# If "off" mode
if (( new_mode == MODES_COUNT - 1 )); then
  notify-send "hypridle" "Mode: Off (no sleep)"
  exit 0
fi

# Get timeout
timeout=${TIMEOUTS[new_mode]}
dim_time=$(( timeout - 30 ))
lock_time=$(( timeout + 60 ))

# Generate dynamic config
cat > "$HYPRIDLE_CONF" <<EOF
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
}

# dim screen before sleep
listener {
    timeout = $dim_time
    on-timeout = brightnessctl -s set 10
    on-resume = brightnessctl -r
}

# keyboard backlight
listener {
    timeout = $dim_time
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
    on-resume = brightnessctl -rd rgb:kbd_backlight
}

# turn off display
listener {
    timeout = $timeout
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}

# suspend
listener {
    timeout = $timeout
    on-timeout = systemctl suspend
}
EOF

# Add lock-after-timeout listener
if (( lock_enabled == 1 )); then
  cat >> "$HYPRIDLE_CONF" <<EOF

# lock after suspend timeout
listener {
    timeout = $lock_time
    on-timeout = hyprlock
}
EOF
fi

# Start hypridle with the dynamic config
hypridle -c "$HYPRIDLE_CONF" &

# Notify
notify-send "hypridle" "Mode: $((timeout/60)) min"
