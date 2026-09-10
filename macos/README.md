# macOS extras

Self-contained; nothing here is wired into `setup.sh` or the shell files.

## Finder Quick Action: "Copy Absolute Path"

Right-click a file or folder in Finder, open the **Quick Actions**
submenu (not Services), choose **Copy Absolute Path**. The full path
lands on the clipboard. Multiple selections are newline-separated.

Finder already has a hidden version of this: hold **Option** in the
right-click menu and "Copy" becomes "Copy as Pathname", or press
**Cmd-Option-C**. The Quick Action just makes it a visible menu item.

### Install on a new machine

```sh
~/dotfiles/macos/install-services.sh
```

The script copies every `services/*.workflow` bundle to
`~/Library/Services`, marks it enabled in Finder's Quick Actions
allow-list, refreshes the services registry, and relaunches Finder.
It is safe to re-run.

### If the item still does not appear

The installer alone was verified sufficient on macOS 26.5: it writes
the same preferences that ticking the box in System Settings does. If a
future macOS changes that shape, tick it by hand once:

1. System Settings > General > Login Items & Extensions.
2. Scroll to Extensions, click the info button next to **Finder**.
3. Tick **Copy Absolute Path**.
4. Right-click a file in Finder; check the Quick Actions submenu.

If it is not in that list at all, macOS did not recognise the bundle.
Open `~/Library/Services/CopyAbsolutePath.workflow` in Automator and
save it once, then re-run the installer.

### Why this needs a script at all

Finder's context menu is not user-editable. Apple exposes three hooks
into it: legacy Services, Quick Actions (Automator workflows, Shortcuts,
app extensions), and Finder Sync extensions. All are allow-listed. A
workflow dropped into `~/Library/Services` is registered automatically
but shows up *unticked* in the Extensions pane, and Finder hides
unticked actions. The allow-list lives in the `pbs` preferences domain
(`FinderActive`, `FinderOrdering`, `NSServicesStatus`), which is what
the installer edits.

### Adding another Quick Action

Build it in Automator (File > New > Quick Action, "Workflow receives
current files or folders in Finder"), save it into `services/`, and
re-run the installer. Each bundle is two small plists and diffs fine.
