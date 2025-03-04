#!/usr/bin/env bash

NUM_WS=5

spaces() {
  HYPR_MONITORS=$(hyprctl monitors -j)
  HYPR_WORKSPACES=$(hyprctl workspaces -j)

  ACTIVE_MONITORS=$(echo "$HYPR_MONITORS" | jq '[.[0].activeWorkspace.id, .[1].activeWorkspace.id]')
  ACTIVE_WORKSPACES=$(echo "$HYPR_WORKSPACES" | jq '[.[] | select(.windows > 0) | .id]')

  json_output=$(jq -c -n --argjson num_ws "$NUM_WS" --argjson active_monitors "$ACTIVE_MONITORS" --argjson active_workspaces "$ACTIVE_WORKSPACES" '
  [range(1; $num_ws+1) as $i |
    {
      workspace_id: $i,
      focused: {
        value: ($i == $active_monitors[0] or $i == $active_monitors[1]),
        monitor: (if $i == $active_monitors[0] then 0 
                  elif $i == $active_monitors[1] then 1 
                  else null end)
      },
      active: ($i | IN($active_workspaces[]))
    }
  ] // []'
  )

  echo "$json_output"
}

spaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | 
  while read -r line; do
    case "$line" in
      *"workspace"*) spaces ;;
    esac
  done
