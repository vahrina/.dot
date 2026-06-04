glow() {
  command glow -w $(( $(tput cols) - 2)) "$@"
}
