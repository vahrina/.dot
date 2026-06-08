copy-command() {
  echo -n $BUFFER | xclip
  zle -M "copied to clipboard"
}
zle -N copy-command
bindkey '^Xc' copy-command
