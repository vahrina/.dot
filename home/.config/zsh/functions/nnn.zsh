n() {
  # block nesting nnn in a subshell spawned inside nnn
  if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn already running"
    return
  fi

  # unmask ctrl-q/ctrl-s/lnext if stty has them bound
  stty start undef
  stty stop undef
  stty lnext undef

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  nnn "$@"

  # cd to the last visited directory on quit
  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    command rm -f "$NNN_TMPFILE" # ignore rm alias, that would print 'removed .. .lastd'
  fi
}
