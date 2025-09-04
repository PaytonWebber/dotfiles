set fish_greeting ""

alias cd="z"
alias vi="nvim"
alias nf="fastfetch"
alias hx="helix"
alias ls="eza"
alias ll="eza -l"
alias icat="kitty icat"
alias find="fd"
alias grep="rg"
alias skb="sk --preview='bat {} --color=always'"
alias fzfb="fzf --preview='bat {} --color=always'"
alias rgf="rg --files | fzf --preview 'rg --color=always --line-number "{}"'"

pyenv init - fish | source
zoxide init fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/payton/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
abbr -a fs fsearch
abbr -a gs gsearch

set -gx EDITOR helix
