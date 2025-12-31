#!/usr/bin/env python3
"""Open a new Chrome window with the selected profile.

This CLI utility exists because Chrome keeps switching workspaces
on macOS when opening a new window on a different profile. It's
a more systemic problem with macOS, hence this workaround.
"""

import json
import shlex
import subprocess
from pathlib import Path
from typing import Optional

import rich
import typer
from rich.console import Console
from rich.table import Table


app = typer.Typer(
    name="chrome-new",
    help="Open a new Chrome window with the selected profile",
    context_settings={"help_option_names": ["-h", "--help"]},
    no_args_is_help=True,
    pretty_exceptions_enable=False,
    add_completion=False,
)
console = Console()

# NOTE: This is macOS specific.
CHROME_PATH = Path("~/Library/Application Support/Google/Chrome").expanduser()


def get_chrome_path() -> Path:
    # TODO: Support Linux too.
    if not CHROME_PATH.exists():
        console.print("[red]Chrome profile path not found[/red]")
        raise typer.Abort()

    return CHROME_PATH


def _line_matches_profile(line: str) -> bool:
    matches = ["Profile", "Default", "Guest"]
    return any(match in line for match in matches)


def get_profiles() -> list[str]:
    chrome_path = get_chrome_path()
    blacklist = {
        "System Profile",
        # "Guest Profile",
    }

    profiles = []
    for entry in chrome_path.iterdir():
        if not entry.is_dir():
            continue
        if not _line_matches_profile(entry.name):
            continue
        if entry.name in blacklist:
            continue
        profiles.append(entry.name)

    profiles.sort()
    return profiles


def get_profile_directory(index: Optional[int]) -> Path:
    profiles = get_profiles()
    if index is None:
        index = 0
    if not (0 <= index < len(profiles)):
        console.print("[red]Invalid profile index[/red]")
        raise typer.Abort()
    chrome_path = get_chrome_path()
    profile = profiles[index]
    profile_dir = chrome_path / profile
    return profile_dir


def load_preferences(profile: str) -> dict:
    chrome_path = get_chrome_path()
    profile_dir = chrome_path / profile
    preferences = profile_dir / "Preferences"
    if not preferences.exists():
        console.print("[red]Preferences file not found[/red]")
        raise typer.Abort()
    with preferences.open() as f:
        prefs_dict = json.load(f)
    return prefs_dict


def get_profile_name(profile: str) -> str:
    prefs = load_preferences(profile)
    return prefs["profile"]["name"]


def custom_help_cb(value: bool, ctx: typer.Context):
    if value:
        typer.echo(ctx.get_help())
        raise typer.Exit()


def HelpOption(help=None):
    if help is None:
        help = "Show this message and exit"
    return typer.Option(
        False,
        "-h",
        "--help",
        is_eager=True,
        callback=custom_help_cb,
        help=help,
    )


@app.command(name="list")
def do_list_profiles():
    """List available Chrome profiles."""
    profiles = get_profiles()
    if not profiles:
        console.print("[red]No profiles found[/red]")
        raise typer.Exit(1)

    table = Table(title="Chrome Profiles")
    table.add_column("Index", justify="center", style="cyan", no_wrap=True)
    table.add_column("Profile", style="magenta")
    table.add_column("Name", style="green")

    for idx, profile in enumerate(profiles):
        profile_name = get_profile_name(profile)
        table.add_row(str(idx), profile, profile_name)

    console.print(table)


@app.command(name="open")
def do_open(
    profile_idx: Optional[int] = typer.Argument(
        None,
        help="Profile index to open",
    ),
    url: Optional[str] = typer.Argument(
        None,
        help="URL to open in the new Chrome window",
    ),
    list_profiles: bool = typer.Option(
        False,
        "--list",
        "-l",
        help="List available profiles",
    ),
    help: bool = HelpOption(),
):
    """Open Chrome with the selected profile."""
    if list_profiles:
        do_list_profiles()
        raise typer.Exit()

    # Quick sanity check.
    profile_dir = get_profile_directory(profile_idx)
    if not profile_dir.exists():
        console.print("[red]Profile directory not found[/red]")
        raise typer.Abort()

    # Chrome wants only the directory name.
    profile_name = profile_dir.name

    # Launch Chrome with the selected profile
    cmd = [
        "open",
        "-na",
        "Google Chrome",
        "--args",
        "--new-window",
        f"--profile-directory={profile_name}",
    ]

    # Add URL to the command if provided
    if url:
        cmd.append(url)

    # For debugging
    cmd_str = shlex.join(cmd)
    dir_str = shlex.quote(str(profile_dir))
    rich.print(f"Profile Directory: [cyan]{dir_str}[/]")
    rich.print(f"Chrome Command: [magenta]{cmd_str}[/]")

    # Launch Chrome
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        console.print(f"[red]Error opening Chrome: {e}[/red]")
        raise typer.Abort()


if __name__ == "__main__":
    app()
