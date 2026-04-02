#!/usr/bin/env bash

set -euo pipefail

selected=$(
  swaymsg -t get_tree | jq -r '
    recurse(.nodes[]?, .floating_nodes[]?) |
    select(.type == "con" and .name != null and .pid > 0) |
    "\(.id)\t\(.app_id // .window_properties.class // "unknown")\t\(.name)"
  ' | awk -F'\t' '{printf "%s — %s\n", $1, $3}' | fuzzel -d -p "Window: "
) || exit 0

con_id=$(echo "$selected" | awk '{print $1}')
[ -n "$con_id" ] && swaymsg "[con_id=$con_id] focus"
