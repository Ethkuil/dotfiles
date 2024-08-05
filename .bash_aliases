# `shopt -s autocd` goes too far for me.
# `.. <num>` will move up three levels.
_cd() {
    if [ -z "$1" ]; then
        cd ..
    else
        cd $(awk -v num="$1" 'BEGIN {while (i++ < num) printf "../"}')
    fi
}
alias ..='_cd'
alias grep='grep --color=auto'
# no `-F` flag so that they can still be used with pipeline
alias la='ls -A'
alias ll='ls -lth'
alias lla='ll -A'
alias ls='ls --color=auto'
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

alias testip='curl -L cip.cc'
alias unproxy='unset ALL_PROXY'

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

    # ------ BEGIN domain specific ------
    alias learn='OPENSSL_CONF="$HOME/.config/thulearn2018/openssl.conf" learn'
    # ------ END domain specific ------

else
    # WSL
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

