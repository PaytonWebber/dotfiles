set fish_greeting ""

alias cd="z"
alias vi="nvim"
alias nf="fastfetch"
#alias hx="helix"
alias ls="eza"
alias ll="eza -l"
alias icat="kitty icat"
alias find="fd"
alias grep="rg"
alias skb="sk --preview='bat {} --color=always'"
alias fzfb="fzf --preview='bat {} --color=always'"
alias rgf="rg --files | fzf --preview 'rg --color=always --line-number "{}"'"

alias docker=podman
alias docker-compose=podman-compose

zoxide init fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/payton/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

set -gx PATH "/home/payton/.bun/bin/" $PATH
set -gx PATH "/home/payton/develop/flutter/bin/" $PATH
set -gx PATH $HOME/.npm-global/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.fly/bin/ $PATH

set -gx PATH "/home/payton/.local/bin" $PATH
set -gx PATH "/home/payton/build/zig-x86_64-linux-0.16.0-dev.2676+4e2cec265/" $PATH
# pnpm end
abbr -a fs fsearch
abbr -a gs gsearch

set -gx EDITOR nvim
set -gx CHROME_EXECUTABLE /usr/bin/chromium-browser

# ESP toolchain
set -gx LIBCLANG_PATH "/home/payton/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"
set -gx PATH "/home/payton/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin" $PATH
