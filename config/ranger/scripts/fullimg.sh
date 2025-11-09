#!/usr/bin/env bash
# Show full-size image in iTerm2 using imgcat

set -euo pipefail

IMG="${1:-}"
[ -z "${IMG}" ] && exit 1

IMGCAT="$(command -v imgcat || true)"
[[ -z "$IMGCAT" && -x "$HOME/.iterm2/imgcat" ]] && IMGCAT="$HOME/.iterm2/imgcat"
[ -z "$IMGCAT" ] && { echo "imgcat not found"; exit 1; }

clear

# No size flags = original resolution (may scroll past terminal)
"$IMGCAT" "$IMG"
