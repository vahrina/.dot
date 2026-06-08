hugo-fast() {
  local f='hugo.log' pid url built

  pid=$(pgrep -f 'hugo server') && kill "$pid" && echo "[suc] killed existing instance @ $pid"

  [[ -f $f && -w $f ]] || { printf "[err] created missing '%s'\n" "$f" >&2; touch "$f"; }
  : > "$f"
  hugo server --noHTTPCache -D > "$f" 2>&1 &
  sleep 2

  pid=$(pgrep -f 'hugo server')
  url=$(grep -m1 -oP 'http://[^\s]+' "$f")
  built=$(grep -m1 -oP 'Built in \K[0-9]+ ms' "$f")
  printf "[suc] logging to: '%s' @ '%s' (%s | %s)\n" "$f" "${url:-unknown}" "${built:-unknown}" "${pid:-unknown}"
}
