#!/usr/bin/env bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# kill already running processes
_ps=(waybar rofi swaync) # adjust processes as needed
for _prs in "${_ps[@]}"; do
    pidof -x "$_prs" >/dev/null && pkill -x "$_prs"
done

sleep 0.2
waybar > /dev/null 2>&1 &
swaync > /dev/null 2>&1 &

# for cava-pywal (note, need to manually restart cava once wallpaper changes)
# ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config" || true

exit 0
