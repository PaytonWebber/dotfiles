#!/usr/bin/env bash

set -euo pipefail

NOTIF_ID_FILE="/tmp/brightness-notif-id"

notify() {
  local pct
  pct=$(brightnessctl -m | cut -d, -f4)
  local id
  id=$(cat "$NOTIF_ID_FILE" 2>/dev/null || echo 0)
  notify-send -p -t 2000 -r "$id" -h "int:value:${pct%%%}" "Brightness" "$pct" > "$NOTIF_ID_FILE"
}

case "${1:-}" in
  up)
    brightnessctl set +5%
    notify
    ;;
  down)
    brightnessctl set 5%-
    notify
    ;;
  *)
    echo "Usage: brightness.sh {up|down}" >&2
    exit 1
    ;;
esac
