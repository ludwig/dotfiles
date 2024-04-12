# https://gist.github.com/lovemecomputer/ddf3297882968993416c6961794c41ca

# this theme file placed in "~/.config/powerline-shell/themes/soft-era.py"
# this is a powerline shell theme for use with soft-era iTerm2 theme: https://github.com/soft-aesthetic/soft-era-iterm2

# dark colors:
# 0  black
# 1  darker red (salmon)
# 2  green
# 3  light pink
# 4  blue
# 5  violet?
# 6  purple
# 7  light bg color

# light colors:
# 8  deep purple
# 9  lighter read (coral)
# 10 green
# 11 yellow
# 12 blue
# 13 violet?
# 14 purple
# 15 white

from powerline_shell.themes.default import DefaultColor

class Color(DefaultColor):
    # USERNAME_FG = 15
    # USERNAME_BG = 6
    # USERNAME_FG = 15
    # USERNAME_BG = 13
    USERNAME_FG = 15
    USERNAME_BG = 13
    USERNAME_ROOT_BG = 0

    # HOSTNAME_FG = 15
    # HOSTNAME_BG = 10
    # HOSTNAME_FG = 15
    # HOSTNAME_BG = 14
    # HOSTNAME_FG = 3
    # HOSTNAME_BG = 14
    HOSTNAME_FG = 7
    HOSTNAME_BG = 14

    HOME_SPECIAL_DISPLAY = False
    HOME_BG = 7
    HOME_FG = 6
    PATH_FG = 14
    PATH_BG = 7
    CWD_FG = 0
    SEPARATOR_FG = 14

    READONLY_BG = 0
    READONLY_FG = 15

    SSH_BG = 0
    SSH_FG = 15

    REPO_CLEAN_FG = 0
    REPO_CLEAN_BG = 7
    REPO_DIRTY_FG = 5
    REPO_DIRTY_BG = 7

    JOBS_FG = 4
    JOBS_BG = 7

    CMD_PASSED_FG = 15
    CMD_PASSED_BG = 2
    CMD_FAILED_FG = 15
    CMD_FAILED_BG = 1

    SVN_CHANGES_FG = REPO_DIRTY_FG
    SVN_CHANGES_BG = REPO_DIRTY_BG

    GIT_AHEAD_BG = 7
    GIT_AHEAD_FG = 4
    GIT_BEHIND_BG = 7
    GIT_BEHIND_FG = 6
    GIT_STAGED_BG = 7
    GIT_STAGED_FG = 2
    GIT_NOTSTAGED_BG = 7
    GIT_NOTSTAGED_FG = 5
    GIT_UNTRACKED_BG = 7
    GIT_UNTRACKED_FG = 5
    GIT_CONFLICTED_BG = 7
    GIT_CONFLICTED_FG = 1
    GIT_STASH_BG = 7
    GIT_STASH_FG = 6

    VIRTUAL_ENV_BG = 7
    VIRTUAL_ENV_FG = 2

    BATTERY_NORMAL_BG = 7
    BATTERY_NORMAL_FG = 2
    BATTERY_LOW_BG = 7
    BATTERY_LOW_FG = 1

    AWS_PROFILE_FG = 15
    AWS_PROFILE_BG = 2

    TIME_FG = 15
    TIME_BG = 10