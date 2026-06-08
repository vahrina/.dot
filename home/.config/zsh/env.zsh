set -a
typeset -U path

# editor/visual
[[ -n $SSH_CONNECTION ]] && EDITOR=vim || EDITOR=nvim
VISUAL=$EDITOR

# go bin
GOROOT="/usr/local/go"
GOPATH="/usr/local/go/packages"

# pnpm
PNPM_HOME="/home/vah/.local/share/pnpm"


# nvm lazy load
NVM_DIR="$HOME/.nvm"
_nvm_node_bin="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node 2>/dev/null | tail -1)/bin"
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$GOROOT/bin"
  "$GOPATH/bin"
  "$PNPM_HOME/bin"
  "$_nvm_node_bin"
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

# win
WIN_HOME="/mnt/c/Users/${USERNAME:-$(whoami)}"
TYPST_FONT_PATHS="$WIN_HOME/AppData/Local/Microsoft/Windows/Fonts"

set +a
