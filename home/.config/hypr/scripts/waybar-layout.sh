#!/usr/bin/env bash
# Thanks https://github.com/JaKooLit ! #
# Script for waybar layout or configs

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_themes="$HOME/.config/waybar/themes"
waybar_config="$HOME/.config/waybar/config"
rofi_config="$HOME/.config/rofi/themes/waybar-layout.rasi"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to display menu options
menu() {
  options=()
  while IFS= read -r file; do
    options+=("$(basename "$file")")
  done < <(find "$waybar_themes" -maxdepth 1 -type f -exec basename {} \; | sort)

  printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
  ln -sf "$waybar_themes/$1" "$waybar_config"
}

# Main function
main() {
  choice=$(menu | rofi -dmenu -config "$rofi_config")

  if [[ -z "$choice" ]]; then
    echo "no option selected, exiting..."
    exit 0
  fi

  case $choice in
  "no panel")
    pgrep -x "waybar" && pkill waybar || true
    ;;
  *)
    apply_config "$choice"
    "$script_dir/refresh.sh"
    ;;
  esac
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
  pkill rofi
  exit 0
fi

main
