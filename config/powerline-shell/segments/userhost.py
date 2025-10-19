#!/usr/bin/env python
# type: ignore
"""Segment to show `user@host` on the prompt."""

import os
import getpass
from socket import gethostname

from powerline_shell.utils import BasicSegment
from powerline_shell.color_compliment import stringToHashToColorAndOpposite
from powerline_shell.colortrans import rgb2short


# These are (fg_short, bg_short) tuples to use as exceptions.
# For example, the `yappa`` userhost segment was unreadable.
host_color_lut = {
    "yappa": (255, 131),  # from (96, 131)
}


class Segment(BasicSegment):
    def add_to_powerline(self):
        powerline = self.powerline

        # Let's always colorize our segment.
        hostname = gethostname()
        if hostname in host_color_lut:
            fg, bg = host_color_lut[hostname]
        else:
            fg, bg = stringToHashToColorAndOpposite(hostname)
            fg, bg = (rgb2short(*color) for color in (fg, bg))

        if powerline.args.shell == "bash":
            userhost_prompt = r" \u@\h "
        elif powerline.args.shell == "zsh":
            userhost_prompt = r" %n@%m "
        else:
            user = os.getenv("USER")
            host = hostname.split(".")[0]
            userhost_prompt = " (%s@%s) " % (user, host)

        # user_fg = powerline.theme.USERNAME_FG
        # user_bg = self.get_user_bgcolor()
        powerline.append(userhost_prompt, fg, bg)

    def get_user_bgcolor(self):
        if getpass.getuser() == "root":
            return self.powerline.theme.USERNAME_ROOT_BG
        return self.powerline.theme.USERNAME_BG
