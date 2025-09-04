function gsearch
    if test (count $argv) -lt 1
        echo "Usage: gsearch <pattern>"
        return 1
    end

    set pattern $argv[1]

    rg --line-number --color=always $pattern | fzf --ansi --delimiter : --nth 1,2,3 \
        --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' | awk -F: '{print $1, $2}' | read -l file line

    if test -n "$file"
        hx +$line $file
    end
end
