#!/usr/bin/env bash

set -euo pipefail

readonly NUM_WS=5
readonly SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

get_workspaces() {
  local monitors workspaces active_monitors active_workspaces
  
  monitors=$(hyprctl monitors -j) || return 1
  workspaces=$(hyprctl workspaces -j) || return 1
  
  active_monitors=$(jq -c '[.[].activeWorkspace.id]' <<< "$monitors")
  active_workspaces=$(jq -c '[.[] | select(.windows > 0) | .id]' <<< "$workspaces")
  
  jq -c -n \
    --argjson num_ws "$NUM_WS" \
    --argjson active_monitors "$active_monitors" \
    --argjson active_workspaces "$active_workspaces" '
    [range(1; $num_ws + 1) | {
      workspace_id: .,
      focused: {
        value: (. as $i | $active_monitors | any(. == $i)),
        monitor: (. as $i | $active_monitors | index($i))
      },
      active: (. as $i | $active_workspaces | any(. == $i))
    }]'
}

# Initial output
get_workspaces || exit 1

# Monitor for changes
socat -u "UNIX-CONNECT:$SOCKET" - 2>/dev/null | 
  while IFS= read -r event; do
    [[ "$event" == *workspace* ]] && get_workspaces
  done
