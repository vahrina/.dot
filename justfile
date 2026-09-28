rs := "rsync -rtih --no-perms --delete"

default:
  @just --list

# run everything below
backup: komo flow

komo *args:
  @{{rs}} {{args}} \
  "/mnt/c/Users/$USER/.config/komorebi/" \
  "$HOME/.dot/home/.config/komorebi/"

flow *args:
  @{{rs}} {{args}} \
    --delete-excluded \
    --exclude='*.bak' --exclude='cache_*' --exclude='owned_api_key.*' \
    --exclude='Flow.Launcher.Plugin.OneTimePassword/' \
    --exclude='UserSelectedRecord.json' --exclude='MultipleTopMostRecord.json' \
    --include='Settings/***' --include='Themes/***' --exclude='*' \
    "$(ls -d /mnt/c/Users/$USER/Documents/FlowLauncher/app-*/UserData | sort -V | tail -1)/" \
    "$HOME/.dot/home/Documents/FlowLauncher/UserData/"
