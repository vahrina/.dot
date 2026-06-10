# command line buf with preferred editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# autmotatically expand history expr
bindkey ' ' magic-space

# rest of the binds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^H' backward-kill-word
