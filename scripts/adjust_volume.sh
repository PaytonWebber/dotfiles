#!/bin/bash

# Define a unique notification ID for volume
NOTIF_ID=99125

# Default sink for PulseAudio
DEFAULT_SINK=$(pactl info | grep 'Default Sink' | cut -d: -f2 | xargs)

# Increase, decrease, or mute volume
case "$1" in
    up)
        pactl set-sink-volume "$DEFAULT_SINK" +5%   # Increase volume by 5%
        MESSAGE="Volume: Up"
        ;;
    down)
        pactl set-sink-volume "$DEFAULT_SINK" -5%   # Decrease volume by 5%
        MESSAGE="Volume: Down"
        ;;
    mute)
        pactl set-sink-mute "$DEFAULT_SINK" toggle  # Toggle mute
        MESSAGE="Volume: Muted"
        ;;
esac

# Send or update notification
dunstify -r "$NOTIF_ID" -t 750 -u low "$MESSAGE"
