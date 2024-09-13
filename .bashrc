# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# `realpath` for symbolic link
# `BASH_SOURCE[0]` instead of `$0` for run with `source` or `.`
dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
. "$dir/platform.sh"

_match_files_with_err_suppressed() {
  # Convention: scenes use lower case, platforms contain capitals.
  (ls "$prefix"* 2>/dev/null || true) | grep -E "^$prefix[._a-z]*$1[._a-z]*$" || true
}

_run_specific() {
  prefix="$dir/$1"

  platform_agnostic=($(_match_files_with_err_suppressed ''))
  for f in "${platform_agnostic[@]}"; do . "$f"; done

  # The followings may overwrite part of the formers.
  platform_specific=($(_match_files_with_err_suppressed $(os)))
  [ -f /etc/wsl.conf ] && platform_specific+=($(_match_files_with_err_suppressed WSL))
  for f in "${platform_specific[@]}"; do . "$f"; done
}

# --- shell itself ---

# history related
PROMPT_COMMAND='history -a'
shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE="?:??:pwd:exit:history*:zz *"
HISTTIMEFORMAT='%F %T '
shopt -s cmdhist
shopt -s histverify

shopt -s globstar
shopt -s extglob

# --- environment ---

export PYTHONSTARTUP=~/.pythonrc
export VISUAL=vim
if [ -d "$HOME/bin" ]; then
  # not idempotent, but it doesn't matter.
  export PATH="$HOME/bin:$PATH"
fi

search_paths=("/home" "/srv" "/var")

_run_specific .bashrc.env

# --- alias ---

# de facto standard

alias grep='grep --color=auto'
# no `-F` flag so that they can still be used with pipeline
alias la='ls -A'
alias ll='ls -lth'
alias lla='ll -A'
alias ls='ls --color=auto'

# my own

# `shopt -s autocd` goes too far for me.
# `.. <num>` will move up <num> levels.
_cd() {
  if [ -z $1 ]; then
    cd ..
  else
    cd $(awk -v num=$1 'BEGIN {while (num--) printf "../"}')
  fi
}
alias ..='_cd'
zz() {
  pattern="$1"
  shift
  if [ "$#" -eq 0 ]; then
    paths=("${search_paths[@]}")
  else
    paths=("$@")
  fi
  cd "$(fd -td "$pattern" "${paths[@]}" | fzf)"
}

alias unproxy='unset https_proxy http_proxy all_proxy'
alias proxy='export https_proxy=http://$proxy_host:$proxy_port; export http_proxy=http://$proxy_host:$proxy_port; export all_proxy=socks5://$proxy_host:$proxy_port'

_run_specific .bash_aliases

# --- execute ---

_run_specific .bashrc.exe
