set -a
typeset -U path

# editor/visual
[[ -n $SSH_CONNECTION ]] && EDITOR=nvim || EDITOR=vim
VISUAL=$EDITOR

# go bin
GOROOT="/usr/local/go"
GOPATH="/usr/local/go/packages"
GOTELEMETRY=off

# pnpm
PNPM_HOME="/home/vah/.local/share/pnpm"

# nvm lazy load
NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}

if [[ -d "$NVM_DIR/versions/node" ]]; then
  path+=($NVM_DIR/versions/node/*/bin(N-/))
fi

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$GOROOT/bin"
  "$GOPATH/bin"
  "$PNPM_HOME/bin"
  "$HOME/bin"
  $path
)

# pager
COLORTERM=truecolor
GROFF_NO_SGR=1
MANPAGER=less

# pager colors
LESS_TERMCAP_mb=$'\e[1;38;5;183m'
LESS_TERMCAP_md=$'\e[1;38;5;183m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[38;5;236;48;5;183m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[1;38;5;217m'
LESS_TERMCAP_mr=$'\e[7m'
LESS_TERMCAP_mh=$'\e[2m'

set +a
