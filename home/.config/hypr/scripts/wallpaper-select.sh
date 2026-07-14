#!/usr/bin/env bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# adjusted by @vahrina: random picker + fuzzy finder

set -uo pipefail

wallpaperDir="$HOME/pictures/wallpapers"
themesDir="$HOME/.config/rofi/themes"

FPS=60
TYPE="simple"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
AWWW_PARAMS=(--transition-fps "$FPS" --transition-type "$TYPE" --transition-duration "$DURATION" --transition-bezier "$BEZIER")

# lock/state files for daemon
LOCKFILE="/tmp/wallpaper.lock"
STATE_FILE="/tmp/wallpaper.state"
INTERVAL="30m"

# retrieve images
mapfile -t PICS < <(find -L "$wallpaperDir" -type f -iregex '.*\.\(jpg\|jpeg\|png\|gif\)$' | sort)
if [ ${#PICS[@]} -eq 0 ]; then
  notify-send "no wallpapers found in $wallpaperDir"
  exit 1
fi

# initialize awww if needed
init_awww() {
  command -v awww &>/dev/null && ! awww query &>/dev/null && awww init
}

executeCommand() {
  local file="$1"
  init_awww

  [ -f "$file" ] || return 1

  # set wallpaper in background
  awww img "$file" "${AWWW_PARAMS[@]}" &

  {
    if wal -i "$file" --backend pywal; then
      pkill -USR1 waybar
      for pts in /dev/pts/[0-9]*; do
        cat ~/.cache/wal/sequences >"$pts" 2>/dev/null
      done
    else
      notify-send "wal failed on $file"
    fi
  } &

  ln -sf "$file" "$HOME/.wallpaper"
}

menu() {
  for i in "${!PICS[@]}"; do
    if [[ ! "${PICS[$i]}" =~ \.gif$ ]]; then
      printf "%s\x00icon\x1f%s\n" "$(basename "${PICS[$i]}" | cut -d. -f1)" "${PICS[$i]}"
    else
      printf "%s\n" "$(basename "${PICS[$i]}")"
    fi
  done
}

get_next_wallpaper() {
  local index=0
  [ -f "$STATE_FILE" ] && index=$(cat "$STATE_FILE")
  local next="${PICS[$index]}"
  index=$(((index + 1) % ${#PICS[@]}))
  echo "$index" >"$STATE_FILE"
  echo "$next"
}

auto_cycle() {
  if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    echo "another instance is running, exiting..."
    exit 1
  fi
  echo $$ >"$LOCKFILE"
  trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT

  # shuffle wallpapers
  for i in $(seq $((${#PICS[@]} - 1)) -1 1); do
    j=$((RANDOM % (i + 1)))
    tmp=${PICS[i]} PICS[i]=${PICS[j]} PICS[j]=$tmp
  done

  local index=0
  while true; do
    executeCommand "${PICS[$index]}"
    index=$(((index + 1) % ${#PICS[@]}))
    sleep "$INTERVAL"
  done
}

main_menu() {
  local choice
  local randomNumber=$((($(date +%s) + RANDOM) + $$))
  local randomPicture="${PICS[$((randomNumber % ${#PICS[@]}))]}"

  choice=$(menu | rofi -show -dmenu -matching fuzzy -theme "${themesDir}/wallpaper-select.rasi")

  [[ -z "$choice" ]] && exit 0
  [[ "$choice" = "[${#PICS[@]}] Random" ]] && {
    executeCommand "$randomPicture"
    return 0
  }

  local selectedFile=""
  for file in "${PICS[@]}"; do
    [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]] && selectedFile="$file" && break
  done

  if [[ -n "$selectedFile" ]]; then
    executeCommand "$selectedFile"
  else
    echo "'$file' not found"
    exit 1
  fi
}

if pidof rofi &>/dev/null; then
  pkill rofi
  exit 0
fi

case "${1:-}" in
-m | --menu) main_menu ;;
-n | --next) executeCommand "$(get_next_wallpaper)" ;;
-d | --daemon) auto_cycle ;;
*) main_menu ;;
esac
