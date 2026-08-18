cd() {
  builtin cd "${1:-$HOME}" || return
  if command -v /usr/bin/eza &>/dev/null; then
    eza --group-directories-first --grid
  else
    /usr/bin/ls
  fi
}
