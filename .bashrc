#!/bin/bash

os() {
  case $OSTYPE in
    linux-gnu* | darwin* | freebsd*) echo "Unix" ;;
    cygwin | msys | win32) echo "Windows" ;;
    *) echo "Unknown" ;;
  esac
}

alias '..=cd ..' # 'shopt -s autocd' goes too far for me.
# no `-F` flag so that they can still be used with pipeline
alias la='ls -A'
alias ll='ls -lth'
alias lla='ll -A'
alias ls='ls --color=auto'
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

export VISUAL=vim
export PYTHONSTARTUP=~/.pythonrc

alias testip='curl -L cip.cc'
alias unproxy='unset ALL_PROXY'
port=7890

## --- BEGIN unstable ---
export GOPROXY=https://goproxy.cn,direct
## --- END unstable ---

if [[ "$(os)" == "Windows" ]]; then
    alias proxy='export ALL_PROXY=http://localhost:$port'
    zz() {
        pattern="$1"
        shift
        if [ "$#" -eq 0 ]; then
            paths=("/d")
        else
            paths=("$@")
        fi
        cd "$(fd -td "$pattern" "${paths[@]}" | fzf)"
    }

    # Dependent on FFmpeg
    alias duration='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'

    # some specific tools related
    alias tldr='tldr --linux'
    export PROMPT_COMMAND='history -a'
    export PATH="$PATH:/c/msys64/usr/bin/"
    export PYTHONIOENCODING='utf-8'

else
    # WSL
    export host_ip=$(cat /etc/resolv.conf | awk '$1 == "nameserver" { print $2 }')
    alias proxy='export ALL_PROXY=http://$host_ip:$port'
    zz() {
        pattern="$1"
        shift
        if [ "$#" -eq 0 ]; then
            paths=("/home" "/srv" "/var")
        else
            paths=("$@")
        fi
        cd "$(fd -td "$pattern" "${paths[@]}" | fzf)"
    }
fi

proxy

