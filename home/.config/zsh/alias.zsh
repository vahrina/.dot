# -- safety/verbosity
for cmd in cp mv ln;        do alias $cmd="$cmd -v"; done
for cmd in chmod chown;     do alias $cmd="$cmd -vc"; done
for cmd in md mkdir;        do alias $cmd="mkdir -pv"; done
for cmd in rd rmdir;        do alias $cmd="rmdir -v"; done
alias rm="rm -iv"
alias rsync="rsync -vh --progress"

# -- useful stuff
alias reload="source $HOME/.zshrc"
alias path='echo ${(F)path}'
alias j="jobs -l"

# -- ext binaries
# nvim
for cmd in v vim;           do alias $cmd="nvim"; done
# bat
alias bat="/bin/batcat --color=always --style=numbers,changes"
# tmux
alias t="tmux new-session -A -s main"
# eza
EZA_OPTS="--icons=auto --group-directories-first --git --no-time --no-filesize --classify=always -A"
alias l="eza $EZA_OPTS -l --no-permissions --octal-permissions --no-user --no-git"
alias ll="eza $EZA_OPTS -la"
alias lt="eza $EZA_OPTS -Tal --level=3 --no-permissions --octal-permissions"
# python3
alias py="python3"
alias pip="pip3"
alias pyvenv="python3 -m venv .venv && source .venv/bin/activate"
