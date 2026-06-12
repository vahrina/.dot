# -- history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# annoying bell flash
unsetopt BEEP

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "$ZINIT_HOME/zinit.zsh"

autoload -Uz compinit && compinit

zinit snippet OMZP::git
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::completion.zsh
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting

# -- load own config stuff
for f in "$HOME"/.config/zsh/{env.zsh,alias.zsh,keybind.zsh,functions/*.zsh}; do source "$f"; done

# -- rest stuff
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd zd)"
[[ $PWD == /mnt/c* ]] && cd ~

# -- custom logo, see /.local/bin/inf
inf
