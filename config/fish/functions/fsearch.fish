function fsearch
    if test (count $argv) -lt 1
        echo "Usage: fsearch <pattern> [fd options]"
        return 1
    end

    set pattern $argv[1]
    set extra_args $argv[2..-1]

    # List files with fd and let fzf preview them with bat
    set file (fd --color=always $pattern $extra_args | fzf --ansi --preview "bat --style=numbers --color=always {}")

    if test -n "$file"
        hx $file
    end
end
