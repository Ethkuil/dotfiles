#!/bin/bash

os() {
  case $OSTYPE in
    linux-gnu* | darwin* | freebsd*) echo "Unix" ;;
    cygwin | msys | win32) echo "Windows" ;;
    *) echo "Unknown" ;;
  esac
}

alias '..=cd ..' # 'shopt -s autocd' goes too far for me.
alias la='ls -A'
alias ll='ls -lth'
alias lla='ll -A'
alias ls='ls -F --color=auto -v'
mkcd() {
    mkdir -p "$1"
    cd "$1"
}
eval "$(zoxide init bash)"

export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc

alias testip='curl -L cip.cc'
alias unsetproxy='unset ALL_PROXY'
port=7890

## --- BEGIN unstable ---
export GOPROXY=https://goproxy.cn,direct
## --- END unstable ---

if [[ "$(os)" == "Windows" ]]; then
    alias setproxy='export ALL_PROXY=http://localhost:$port'
    # it's also nice to leave $1 empty and only filter in fzf, which is fuzzy!
    zz() {
        cd "$(fd -td "$1" '/d' | fzf)"
    }

    # Dependent on FFmpeg
    alias duration='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'

    export PROMPT_COMMAND='history -a'
    export PATH="$PATH:/c/msys64/usr/bin/"
    export PYTHONIOENCODING='utf-8'

else
    # WSL
    export host_ip=$(cat /etc/resolv.conf | awk '$1 == "nameserver" { print $2 }')
    alias setproxy='export ALL_PROXY=http://$host_ip:$port'
    zz() {
        cd "$(fd -td "$1" '/home' '/srv' '/var' | fzf)"
    }
fi

setproxy