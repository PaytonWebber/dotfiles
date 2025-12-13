#!/usr/bin/env bash

set -euo pipefail

NIX_CHANNEL="25.05"

find_browser() {
    local browser_priority=("firefox")
    
    # Get window list and parse JSON
    local windows
    windows=$(hyprctl clients -j)
    
    # Find browser windows
    for browser in "${browser_priority[@]}"; do
        local window_address
        window_address=$(echo "$windows" | jq -r ".[] | select(.class | test(\"$browser\"; \"i\")) | .address" | head -n1)
        
        if [[ -n "$window_address" ]]; then
            echo "$window_address"
            return 0
        fi
    done
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
    
    local browser_address
    browser_address=$(find_browser)
    
    # Focus browser and open URL
    if [[ -n "$browser_address" ]]; then
        hyprctl dispatch focuswindow "address:${browser_address}" &
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
