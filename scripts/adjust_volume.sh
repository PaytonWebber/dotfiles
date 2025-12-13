get_volume_percent() {
    local volume_output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    echo "$volume_output" | awk '{printf "%.0f", $2 * 100}'
}

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        MESSAGE="Volume: $(get_volume_percent)% (Up)"
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        MESSAGE="Volume: $(get_volume_percent)% (Down)"
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        MUTE_STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
        if [[ $MUTE_STATUS == *"MUTED"* ]]; then
            MESSAGE="Volume: $(get_volume_percent)% (Muted)"
        else
            MESSAGE="Volume: $(get_volume_percent)% (Unmuted)"
        fi
        ;;
esac

makoctl dismiss 2>/dev/null
notify-send -t 750 -u low "$MESSAGE"
