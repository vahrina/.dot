# -- oh my zsh
export ZSH="$HOME/.oh-my-zsh"

# -- zstyles & performance
zstyle ':omz:update' mode auto
zstyle ':omz:plugins*' lazy yes
zstyle ':omz:lib:git' disable-status true
DISABLE_UNTRACKED_FILES_DIRTY=1
DISABLE_AUTO_TITLE="true"

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

# -- plugins
plugins=(
  git
  history-substring-search
  zsh-syntax-highlighting
  vi-mode)
source $ZSH/oh-my-zsh.sh

# -- load config
for f in $HOME/.config/zsh/{env.zsh,alias.zsh,keybind.zsh,functions/*.zsh}; do source $f; done

# rest stuff
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
[[ $PWD == /mnt/c* ]] && cd ~

inf
