#!/bin/bash

# Define a unique notification ID
NOTIF_ID=99123

# Increase or decrease brightness
if [ "$1" == "up" ]; then
    light -A 10
elif [ "$1" == "down" ]; then
    light -U 10
fi

# Get the current brightness level
BRIGHTNESS=$(light | xargs printf "%.0f")

# Send or update notification
dunstify -r "$NOTIF_ID" -t 750 -u low "Brightness: $BRIGHTNESS%"
