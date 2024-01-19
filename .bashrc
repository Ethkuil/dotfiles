# --- General ---
alias '..'='cd ..'
alias la='ls -A'
alias ll='ls -lth'
alias lla='ll -A'
alias ls='ls -F --color=auto -v'
mkcd() {
    mkdir -p "$1"
    cd "$1"
}
alias testip='curl -L cip.cc'
alias unsetproxy='unset ALL_PROXY'
eval "$(zoxide init bash)"
# it's also nice to leave $1 empty and only filter in fzf, which is fuzzy!
zz() {
  cd $(fd -td "$1" /d/ | fzf)
}

export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc

# --- Windows Only ---
alias setproxy='export ALL_PROXY=http://localhost:7890'
export PROMPT_COMMAND='history -a'
export PATH="$PATH:/c/msys64/usr/bin/"
export PYTHONIOENCODING='utf-8'

# Dependent on FFmpeg
alias duration='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'

## --- BEGIN unstable ---
alias ?='gh copilot explain'
alias ??='gh copilot suggest'

alias explain='start https://explainshell.com'

export GOPROXY=https://goproxy.cn,direct
## --- END unstable ---

# --- Dependent on the above ---
setproxy
