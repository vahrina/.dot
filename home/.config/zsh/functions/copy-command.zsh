copy-command() {
  echo -n $BUFFER | xclip -selection clipboard
  zle -M "copied to clipboard"
}
zle -N copy-command
bindkey '^Xc' copy-command
