#!/bin/bash
# Install every Automator Quick Action under macos/services/ into
# ~/Library/Services so it shows up in Finder's right-click menu
# (under Quick Actions / Services). Safe to re-run; existing copies
# are replaced.
#
# Usage:  ~/dotfiles/macos/install-services.sh
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")/services" && pwd)"
dest="$HOME/Library/Services"
mkdir -p "$dest"

for wf in "$src"/*.workflow; do
  name="$(basename "$wf")"
  rm -rf "${dest:?}/$name"
  cp -R "$wf" "$dest/$name"
  echo "installed $name"
done

# Ask the pasteboard/services daemon to pick up the new entries.
/System/Library/CoreServices/pbs -flush 2>/dev/null || true
/System/Library/CoreServices/pbs -update 2>/dev/null || true
echo "done. If the menu item does not appear, log out and back in."
