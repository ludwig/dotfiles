[ -z "$PS1" ] && return

# ----------------------------------------------------------------------------
# Prompt settings

# Display current git branch in bash prompt
# http://asemanfar.com/Current-Git-Branch-in-Bash-Prompt
# http://betterexplained.com/articles/aha-moments-when-learning-git/
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "

# Number of trailing components to retain when expanding \w and \W
export PROMPT_DIRTRIM=3

# ----------------------------------------------------------------------------
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

# ----------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------

if [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
    source /usr/local/etc/profile.d/bash_completion.sh
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
if [ -f ~/.bash_aliases2 ]; then
    source ~/.bash_aliases2
fi

# Local bashrc file.
# Use this for machine-specific initializations (e.g. sourcing virtualenvwrapper.sh)
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
