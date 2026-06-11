hist() {
  local selected ret
  selected=$(
    fc -nrl 1 \
      | fzf \
        --exact \
        --tiebreak=index \
        --height=45% \
        --border=rounded \
        --pointer='~' \
        --query="$BUFFER" \
        --bind='ctrl-r:abort' \
        --preview-window='bottom:3:wrap:hidden'
    )

    ret=$?
    [[ $ret -eq 0 && -n $selected ]] && {
      BUFFER="$selected"
      CURSOR=${#BUFFER}
    }
    zle reset-prompt
}
zle -N hist
bindkey '^R' hist
