#!/usr/bin/env bash

NUM_WS=5

spaces() {
  ACTIVE_WS=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')

  ACTIVE_WORKSPACES=$(hyprctl workspaces -j)

  json_output="["

  for ((i=1; i<=NUM_WS; i++)); do
    if [[ "$i" == "$ACTIVE_WS" ]]; then
      focused=true
    else
      focused=false
    fi

    if echo "$ACTIVE_WORKSPACES" | grep -q "\"id\": $i"; then
      active=true
    else
      active=false
    fi

    json_output+="{\"id\": \"$i\", \"focused\": $focused, \"active\": $active}"

    if [[ $i -lt $NUM_WS ]]; then
      json_output+=", "
    fi
  done

  json_output+="]"

  echo "$json_output"
}

spaces

# Listen for workspace events and re-run the spaces function on update
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  spaces
done

