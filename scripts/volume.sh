#!/usr/bin/env bash

set -euo pipefail

NOTIF_ID_FILE="/tmp/vol-notif-id"

get_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | awk '{gsub(/%/,""); print $5}'
}

notify() {
  local msg="$1"
  local id
  id=$(cat "$NOTIF_ID_FILE" 2>/dev/null || echo 0)
  notify-send -p -t 2000 -r "$id" -h "int:value:$(get_volume)" "Volume" "$msg" > "$NOTIF_ID_FILE"
}

case "${1:-}" in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    notify "$(get_volume)%"
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    notify "$(get_volume)%"
    ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    state=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}' | sed 's/yes/Muted/;s/no/Unmuted/')
    notify "$state"
    ;;
  *)
    echo "Usage: volume.sh {up|down|mute}" >&2
    exit 1
    ;;
esac
