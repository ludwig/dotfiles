#!/usr/bin/env python

import shutil
import sys
from pathlib import Path

import typer
from rich.console import Console

app = typer.Typer()
console = Console()


def is_powerline_shell_installed():
    return shutil.which("powerline-shell") is not None

def unexpanduser(path: Path) -> Path:
    return Path(str(path).replace(str(Path.home()), "~"))


def link_path(source: Path, target: Path):
    fmt = {
        "source": unexpanduser(source),
        "target": unexpanduser(target),
    }
    if not target.exists():
        target.symlink_to(source)
        msg = (
            "Created new symlink "
            "[green bold]{target}[/green bold] -> "
            "[green bold]{source}[/green bold]"
        )
        console.print(msg.format(**fmt))
        return
    if target.is_dir():
        msg = "Directory already exists: [magenta bold]{target}"
        console.print(msg.format(**fmt))
    elif target.is_symlink():
        old_source = target.readlink().resolve()
        if old_source == source.resolve():
            msg = (
                "Symlink is up to date: "
                "[magenta bold]{target}[/magenta bold] -> "
                "[magenta bold]{source}[/magenta bold]"
            )
            console.print(msg.format(**fmt))
            return
        target.unlink()
        target.symlink_to(source)
        fmt["old_source"] = unexpanduser(old_source)
        msg = (
            "Updated symlink with "
            "[magenta bold]{target}[/magenta bold] -> "
            "[magenta bold]{source}[/magenta bold]"
            "Removed older source "
            "[magenta bold]{old_source}[/magenta bold]"
        )
        console.print(msg.format(**fmt))


@app.command()
def install_links():
    script_dir = Path(__file__).resolve().parent
    target_dir = Path("~/.config/powerline-shell").expanduser()

    # Before we install anything, let's make sure powerline-shell
    # has been installed.
    if not is_powerline_shell_installed():
        msg = (
            "[red]Could not find [bold]powerline-shell[/bold] in PATH[/red]\n"
            "Use '[bold]pipx install powerline-shell[/bold]' to install it."
        )
        console.print(msg)
        sys.exit(-1)

    if not target_dir.exists():
        target_dir.mkdir(parents=True, exist_ok=True)
        console.print(f"[green]Created new directory [bold]{target_dir}[/bold]")

    manifest = ["config.json", "themes", "segments"]
    for item in manifest:
        source = script_dir / item
        target = target_dir / item
        link_path(source, target)


if __name__ == "__main__":
    app()
