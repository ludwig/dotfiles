# type: ignore
"""Powerline theme for helix."""

import powerline_shell.themes.default as default
import powerline_shell.themes.washed as washed


# Colors from https://www.nordtheme.com/docs/colors-and-palettes
night0 = 236 # nord0
night1 = 237 # nord1
night2 = 238 # nord2
night3 = 239 # nord3
snow0  = 253 # nord4
snow1  = 254 # nord5
snow2  = 255 # nord6
frost0 = 109 # nord7
frost1 = 111 # nord8
frost2 = 110 # nord9
frost3 = 68  # nord10
red    = 167 # nord11
orange = 173 # nord12
yellow = 179 # nord13
green  = 150 # nord14
purple = 139 # nord15


class Color(washed.Color):

    AWS_PROFILE_FG = night0
    AWS_PROFILE_BG = frost2

    TIME_BG = night0
    TIME_FG = 250

    HOME_SPECIAL_DISPLAY = True
    #PATH_BG = default.Color.PATH_BG
    #PATH_FG = default.Color.PATH_FG
    #CWD_FG = default.Color.CWD_FG
    #SEPARATOR_FG = default.Color.SEPARATOR_FG
