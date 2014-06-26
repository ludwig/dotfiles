# ~/.bashrc: executed by bash(1) for non-login shells.
# For examples, see /usr/share/doc/bash/examples/startup-files
# in the package bash-doc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


###############################################################################
# Detect platform
# http://stackoverflow.com/questions/394230/detect-os-from-a-bash-script

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform="macosx"
fi


###############################################################################
# Prompt settings

# Display current git branch in bash prompt
# http://asemanfar.com/Current-Git-Branch-in-Bash-Prompt
# http://betterexplained.com/articles/aha-moments-when-learning-git/
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
#export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \W \[\033[31m\]\$(parse_git_branch) \[\033[00m\]$\[\033[00m\] "
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "

# alternatively, use a simple but informative prompt
#export PS1='\u@\h:\w\$ '

# a few alternate prompts
#PS1_SHOW_PWD="cd \w\n\u@\h:\W\$ "

# number of trailing components to retain when expanding \w and \W
export PROMPT_DIRTRIM=2


###############################################################################
# History settings

# http://bradchoate.com/weblog/2006/05/19/daily-history-files-for-bash
#export HISTFILE="~/.history/`date +%Y%m%d`.hist"
export HISTFILESIZE=10000
export HISTSIZE=10000

# Erase duplicate lines from history, and don't save commands
# which start with a space. See bash(1) for more options.
export HISTCONTROL=erasedups:ignorespace

# ignore some boring stuff. The " *" bit ignores all command lines
# starting with whitespace, useful to selectively avoid the history
export HISTIGNORE="ls:cd:cd ..:..*: *"

# ignore these while tab-completing
export FIGNORE="CVS:.svn:.git"

# Append to history file instead of overwriting it
shopt -s histappend


###############################################################################
# Shell options

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't use Ctrl-D to exit
set -o ignoreeof

# Some more shell options - see bash(1)
shopt -s cdspell dotglob nocaseglob no_empty_cmd_completion

# Use vi-style command line editing
set -o vi

# Enable globstar ** patterns
[ "$BASH_VERSINFO" -ge "4" ] && shopt -s globstar

###############################################################################
# Terminal settings

if [[ $platform == "linux" ]]; then

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        *color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        PS1="\[\033[00m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "
    else
        #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
        PS1="\u@\h:\w\$(parse_git_branch)\$ "
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

fi


###############################################################################
# Misc functions and aliases

# pwd in the title bar
# http://www.blog.montgomerie.net/pwd-in-the-title-bar-or-a-regex-adventure-in-bash
function directory_to_titlebar
{
    # The maximum length we want (seems to fit nicely in a default length
    # Terminal title bar).
    local pwd_length=42

    # Get the current working directory. We'll format it in $dir.
    local dir="$PWD"

    # Substitute a leading path that's in $HOME for "~"
    if [[ "$HOME" == ${dir:0:${#HOME}} ]]; then
        dir="~${dir:${#HOME}}"
    fi

    # Append a trailing slash if it's not there already.
    if [[ ${dir:${#dir}-1} != "/" ]]; then
        dir="$dir/"
    fi

    # Truncate if we're too long.
    # We preserve the leading '/' or '~/', and substitute ellipses
    # for some directories in the middle.
    if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]]; then
        local tilde=${BASH_REMATCH[1]}
        local directory=${BASH_REMATCH[2]}

        # At this point $directory is the truncated end-section of the
        # path. We will now make it only contain full directory names
        # (e.g., "ibrary/Mail" -> "/Mail").
        if [[ "$directory" =~ [^/]*(.*) ]]; then
            directory=${BASH_REMATCH[1]}
        fi

        # Can't work out if it's possible to use the Unicode ellipsis,
        # '…' (Unicode 2026). Directly embedding it in the string does
        # not seem to work, and \u escape sequences ('\u2026') are not
        # expanded.
        #printf -v dir "$tilde/\u2026$s", $directory
        dir="$tilde/...$directory"
    fi

    # Don't embed $dir directly in printf's first argument, because it's
    # possible it could contain printf escape sequences.
    printf "\033]0;%s\007" "$dir"
}
case "$TERM" in
    xterm*) export PROMPT_COMMAND="directory_to_titlebar; $PROMPT_COMMAND" ;;
esac

## Alternatively, use this one
#function update_terminal_cwd()
#{
#    # Identify the directory using a "file:" scheme URL,
#    # including the host name to disambiguate local vs.
#    # remote connections. Percent-escape spaces.
#    local SEARCH=' '
#    local REPLACE='%20'
#    local PWD_URL="file://${HOSTNAME}${PWD//$SEARCH/$REPLACE}"
#    printf '\e]7;%s\a' "$PWD_URL"
#}
#if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
#    export PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
#fi

# switch into dirname containing file
cdf   () { cd    "$(dirname "$(locate "$1" | head -n 1)")"; }
pushf () { pushd "$(dirname "$(locate "$1" | head -n 1)")"; }

# mkdir and cd if successful
function mkcd
{
    mkdir -p "$@" && builtin cd "$@"
}

# Tip #769 - .. revisited
# http://www.shell-fu.org/lister.php?id=769
function .. ()
{
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir >& /dev/null
}
function ... ()
{
    if [ -z "$1" ]; then
        return
    fi
    local maxlvl=16
    local dir=$1
    while [ $maxlvl -gt 0 ]; do
        dir="../$dir"
        maxlvl=$(($maxlvl - 1));
        if [ -d "$dir" ]; then
            cd $dir >& /dev/null
        fi
    done
}

# Track what you're doing right "now"
# https://news.ycombinator.com/item?id=7409926
function now()
{
    echo $(date "+%Y-%m-%d %H:%M:%S") - "$@" >> $HOME/.now
}

# Tip from a comment at http://nflath.com/2009/08/tramp/
alias edit="emacsclient -t"
function sedit
{
    if [[ $# != 1 ]]; then
    echo 'Wrong number of arguments'
    return
    fi

    case `dirname "$1"` in
    /*) edit /sudo::"$1" ;;
     *) edit /sudo::"${PWD}/$1" ;;
    esac
}

if [[ $platform == "macosx" ]]; then
    # http://news.ycombinator.com/item?id=1157864
    spotlightfile()
    {
        # use spotlight to search for a file
        mdfind "kMDItemDisplayName == '$@'wc";
    }
    spotlightcontent()
    {
        # use spotlight to search file contents
        mdfind -interpret "$@";
    }
    pdfman()
    {
        # display a man page in Preview
        man -t $1 | open -a /Applications/Preview.app -f
    }
fi

# http://news.ycombinator.com/item?id=1157864
google()
{
    python -c "import sys, webbrowser, urllib;   webbrowser.open('http://www.google.com/search?' + urllib.urlencode({'q': ' '.join(sys.argv[1:]) }))" $@
}

# http://tychoish.com/rhizome/9-awesome-ssh-tricks/
ssh-reagent()
{
    for agent in /tmp/ssh-*/agent.*; do
        export SSH_AUTH_SOCK=$agent
        if ssh-add -l 2>&1 > /dev/null; then
            echo "Found working SSH Agent:"
            ssh-add -l
            return
        fi
    done
    echo 'Cannot find ssh agent - maybe you should reconnect and forward it?'
}

# Emacs Tip - Jump to emacs's current directory
# http://www.reddit.com/r/emacs/comments/hd3jm/from_my_bashrc_jump_to_emacss_current_directory/
alias jm='cd $(emacsclient -e "(with-current-buffer (window-buffer (frame-selected-window)) (expand-file-name default-directory))" | '"sed -E 's/(^\")|(\"$)//g')"


# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh /usr/bin/lesspipe)"
elif [ -x /opt/local/bin/lesspipe.sh ]; then
    eval "$(SHELL=/bin/sh /opt/local/bin/lesspipe.sh)"
elif [ -x /usr/local/bin/lesspipe.sh ]; then
    eval "$(SHELL=/bin/sh /usr/local/bin/lesspipe.sh)"
fi

# Check if a command exists in your PATH
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
command_exists()
{
    command -v "$1" >/dev/null 2>&1;
}

# Set GOROOT if golang's go is installed
if command_exists go ; then
    export GOROOT=$(go env GOROOT)
    export PATH="${PATH}:${GOROOT}/bin"
fi

# Add ruby gem's bin directory to our PATH
# http://guides.rubygems.org/faqs/#user-install
if command_exists ruby && command_exists gem ; then
    gem_user_dir="$(ruby -rubygems -e 'puts Gem.user_dir')"
    export PATH="${PATH}:${gem_user_dir}/bin"
fi

# <hr/> for your terminal
# https://github.com/LuRsT/hr
# https://news.ycombinator.com/item?id=7213347
hr() { printf '\e(0'; printf 'q%.0s' $(seq $(tput cols)); printf '\e(B'; }

###############################################################################

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
    source /usr/local/etc/bash_completion
elif [ -f /opt/local/etc/bash_completion ]; then
    source /opt/local/etc/bash_completion
elif [ -f ~/.bash_completion ]; then
    source ~/.bash_completion
fi

# Use z to jump around, if present
# See https://github.com/rupa/z
#if [ -f /usr/local/etc/profile.d/z.sh ]; then
#   source /usr/local/etc/profile.d/z.sh
#fi

# Use fasd, a tool inspired by autojump,z,v
# https://github.com/clvv/fasd
if command_exists fasd ; then
    eval "$(fasd --init auto)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Local bashrc file.
# Use this for machine-specific initializations (e.g. sourcing virtualenvwrapper.sh)
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
