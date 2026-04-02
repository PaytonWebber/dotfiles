#!/usr/bin/env bash

set -euo pipefail

get_focused_title() {
  swaymsg -t get_tree -r | jq -r '
    recurse(.nodes[]?, .floating_nodes[]?) |
    select(.focused == true and .type == "con") |
    .name // ""
  ' | head -1
}

get_focused_title

swaymsg -t subscribe '["window","workspace"]' -m 2>/dev/null |
  while IFS= read -r _event; do
    get_focused_title
  done
