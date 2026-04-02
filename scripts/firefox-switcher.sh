#!/usr/bin/env bash

set -euo pipefail

BT="$HOME/.local/bin/bt"

tabs=$("$BT" list | awk -F'\t' '{print $1 "\t" $2}')

selected=$(echo "$tabs" | awk -F'\t' '{print $2}' | fuzzel -d -p "Firefox: ") || exit 0
[ -n "$selected" ] || exit 0

tab_id=$(echo "$tabs" | awk -F'\t' -v sel="$selected" '$2 == sel {print $1; exit}')
[ -n "$tab_id" ] || exit 0

"$BT" activate "$tab_id"
sleep 0.15

con_id=$(swaymsg -t get_tree | jq -r --arg title "$selected" '
  recurse(.nodes[]?, .floating_nodes[]?) |
  select(.app_id == "org.mozilla.firefox" and (.name // "" | contains($title))) |
  .id' | head -1)

[ -n "$con_id" ] && swaymsg "[con_id=$con_id] focus"
