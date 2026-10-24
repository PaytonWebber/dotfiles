#!/usr/bin/env bash

set -euo pipefail

NIX_CHANNEL="unstable"

find_browser() {
    swaymsg -t get_tree | jq -r '
        recurse(.nodes[]?, .floating_nodes[]?)
        | select(.app_id == "org.mozilla.firefox")
        | .id' | head -n1
}

on_search() {
    local fuzzel_input
    fuzzel_input=$(fuzzel --lines 0 --prompt "search: " --dmenu)
    
    local url
    
    if [[ "$fuzzel_input" =~ ^!nix ]]; then
        local query="${fuzzel_input#!nix }"
        url="https://search.nixos.org/packages?channel=${NIX_CHANNEL}&from=0&size=50&sort=relevance&type=packages&query=${query}"
    
    elif [[ "$fuzzel_input" =~ ^!gh ]]; then
        local remaining="${fuzzel_input#!gh }"
        local extension_suffix=""
        
        # Check for extension filter
        if [[ "$remaining" =~ e:([^ ]+) ]]; then
            local ext="${BASH_REMATCH[1]}"
            remaining="${remaining//e:$ext/}"
            extension_suffix="+path%3A*.${ext}"
        fi
        
        # Trim whitespace
        remaining=$(echo "$remaining" | xargs)
        url="https://github.com/search?q=%22${remaining}%22${extension_suffix}&type=code"
    
    else
        url="https://www.google.com/search?q=${fuzzel_input}"
    fi
    
    local browser_id
    browser_id=$(find_browser)

    if [[ -n "$browser_id" ]]; then
        swaymsg "[con_id=$browser_id] focus" > /dev/null &
    fi
    xdg-open "$url" &
    wait
}

# Main command dispatcher
case "${1:-}" in
    search)
        on_search
        ;;
    *)
        echo "other"
        ;;
esac
