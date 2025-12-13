# Increase or decrease brightness
if [ "$1" == "up" ]; then
    light -A 10
elif [ "$1" == "down" ]; then
    light -U 10
fi

# Get current brightness and send notification
BRIGHTNESS=$(light | xargs printf "%.0f")
makoctl dismiss 2>/dev/null
notify-send -t 750 -u low "Brightness: $BRIGHTNESS%"
