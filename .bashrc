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
alias setproxy='export ALL_PROXY=http://localhost:7890'
alias testip='curl -L cip.cc'
alias unsetproxy='unset ALL_PROXY'
eval "$(zoxide init bash)"

export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc

## --- BEGIN unstable ---
export GOPROXY=https://goproxy.cn,direct
## --- END unstable ---

if [[ "$(os)" == "Windows" ]]; then
    # it's also nice to leave $1 empty and only filter in fzf, which is fuzzy!
    zz() {
        cd "$(fd -td "$1" '/d' | fzf)"
    }

    # Dependent on FFmpeg
    alias duration='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'

    export PROMPT_COMMAND='history -a'
    export PATH="$PATH:/c/msys64/usr/bin/"
    export PYTHONIOENCODING='utf-8'

    setproxy
else
    # WSL
    export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')
    zz() {
        cd "$(fd -td "$1" '/home' '/srv' '/var' | fzf)"
    }
fi

