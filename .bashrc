#!/bin/bash

os() {
  case $OSTYPE in
    linux-gnu* | darwin* | freebsd*) echo "Unix" ;;
    cygwin | msys | win32) echo "Windows" ;;
    *) echo "Unknown" ;;
  esac
}

# variables
export HISTIGNORE="ls:ll:cd:pwd:[bf]g:exit:pwd:history:[ \t]*"
export VISUAL=vim
export PYTHONSTARTUP=~/.pythonrc

port=7890

if [[ "$(os)" == "Windows" ]]; then
    export PROMPT_COMMAND='history -a'
    export PATH="$PATH:/c/msys64/usr/bin/"
    export PYTHONIOENCODING='utf-8'
else
    # WSL
    export host_ip=$(cat /etc/resolv.conf | awk '$1 == "nameserver" { print $2 }')
fi

# alias
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# execute
proxy

