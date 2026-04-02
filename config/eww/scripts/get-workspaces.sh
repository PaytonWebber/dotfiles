#!/usr/bin/env bash

set -euo pipefail

WS_START=${1:?Usage: get-workspaces.sh <start> <end>}
WS_END=${2:?Usage: get-workspaces.sh <start> <end>}

get_workspaces() {
  local workspaces
  workspaces=$(swaymsg -t get_workspaces -r) || return 1

  jq -c -n \
    --argjson start "$WS_START" \
    --argjson end "$WS_END" \
    --argjson workspaces "$workspaces" '
    [range($start; $end + 1) | . as $i | {
      workspace_id: $i,
      focused: ($workspaces | any(.num == $i and .focused)),
      active: ($workspaces | any(.num == $i and .representation != null))
    }]'
}

get_workspaces || exit 1

swaymsg -t subscribe '["workspace","window"]' -m 2>/dev/null |
  while IFS= read -r _event; do
    get_workspaces
  done
