#!/bin/bash
# Install every Automator Quick Action under macos/services/ into
# ~/Library/Services and enable it in Finder's context menu.
# Safe to re-run; existing copies are replaced.
#
# Usage:  ~/dotfiles/macos/install-services.sh
#
# Why the enable step: macOS registers a new workflow in ~/Library/Services
# automatically, but Finder keeps its own allow-list of Quick Actions in the
# `pbs` preferences domain (FinderActive / NSServicesStatus). A new workflow
# is NOT on that list until you tick it in System Settings > General >
# Login Items & Extensions > Finder. We do the equivalent here so the item
# shows up without a trip to System Settings.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")/services" && pwd)"
dest="$HOME/Library/Services"
mkdir -p "$dest"

names=()
for wf in "$src"/*.workflow; do
  name="$(basename "$wf")"
  rm -rf "${dest:?}/$name"
  cp -R "$wf" "$dest/$name"
  echo "installed $name"
  # The menu title is what pbs keys the entry by, not the bundle name.
  title="$(/usr/libexec/PlistBuddy -c 'Print :NSServices:0:NSMenuItem:default' "$wf/Contents/Info.plist")"
  names+=("$title")
done

# Enable each workflow in Finder's Quick Actions allow-list. `defaults
# -dict-add` cannot parse keys containing parentheses, so edit the
# exported plist with Python and import it back through cfprefsd.
export_plist="$(mktemp)"
defaults export pbs "$export_plist" 2>/dev/null || printf '<plist version="1.0"><dict/></plist>' > "$export_plist"
python3 - "$export_plist" "${names[@]}" <<'PY'
import plistlib, sys
path, titles = sys.argv[1], sys.argv[2:]
with open(path, "rb") as f:
    prefs = plistlib.load(f)
active = prefs.setdefault("FinderActive", {})
order = prefs.setdefault("FinderOrdering", {})
status = prefs.setdefault("NSServicesStatus", {})
# Apple stores these as integers; a stray `defaults write` with a plist
# literal can leave strings behind, so normalise before touching anything.
for d in (active, order):
    for k, v in list(d.items()):
        d[k] = int(v)
for title in titles:
    key = f"(null) - {title} - runWorkflowAsService"
    active[key] = 1
    order.setdefault(key, max(order.values(), default=-1) + 1)
    # Mirror exactly what System Settings > Extensions > Finder writes when
    # you tick the box. Observed on macOS 26.5; older guesses with
    # enabled_context_menu / enabled_services_menu did NOT make Finder
    # show the item.
    entry = status.setdefault(key, {})
    entry.pop("enabled_context_menu", None)
    entry.pop("enabled_services_menu", None)
    entry["presentation_modes"] = {
        "ContextMenu": 1, "FinderPreview": 1, "ServicesMenu": 1, "TouchBar": 0,
    }
    print(f"enabled  {title}")
with open(path, "wb") as f:
    plistlib.dump(prefs, f)
PY
defaults import pbs "$export_plist"
rm -f "$export_plist"

# Refresh the services registry and relaunch Finder so the menu rebuilds.
/System/Library/CoreServices/pbs -flush 2>/dev/null || true
/System/Library/CoreServices/pbs -update 2>/dev/null || true
killall Finder 2>/dev/null || true
echo "done. Right-click a file in Finder and look under Quick Actions."
