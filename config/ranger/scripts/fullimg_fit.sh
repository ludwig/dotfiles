#!/usr/bin/env bash
set -euo pipefail

IMG="${1:-}"
[ -z "${IMG}" ] && exit 1

# Find imgcat
IMGCAT="$(command -v imgcat || true)"
[[ -z "$IMGCAT" && -x "$HOME/.iterm2/imgcat" ]] && IMGCAT="$HOME/.iterm2/imgcat"
[ -z "$IMGCAT" ] && { echo "imgcat not found"; exit 1; }

# Fit inside current terminal (cells); preserves aspect ratio
ROWS="$(tput lines)"
COLS="$(tput cols)"

clear

"$IMGCAT" -H "$ROWS" -W "$COLS" "$IMG"
