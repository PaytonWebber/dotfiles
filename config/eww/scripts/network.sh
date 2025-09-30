#!/usr/bin/env bash

get_network_info() {
  local ssid signal connected
  
  # Check if connected and get SSID
  ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes:' | cut -d: -f2)
  
  if [[ -n "$ssid" ]]; then
    # Get signal strength
    signal=$(nmcli -t -f active,signal dev wifi | grep '^yes:' | cut -d: -f2)
    connected=true
  else
    signal=0
    ssid=""
    connected=false
  fi
  
  jq -n -c \
    --argjson connected "$connected" \
    --argjson signal "${signal:-0}" \
    --arg ssid "$ssid" \
    '{connected: $connected, signal: $signal, ssid: $ssid}'
}

# Initial output
get_network_info

# Monitor for changes every 5 seconds
while true; do
  sleep 5
  get_network_info
done
