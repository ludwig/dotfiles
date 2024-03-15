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

function mkcd() {
    local dir="$1"
    mkdir -p "${dir}"
    cd "${dir}"
}

function mk-today() {
    local dir="${HOME}/journal/$(date +%Y)/$(date +%m-%d)"
    mkdir -p "${dir}"
    cd "${dir}"
}

function mk-prev() {
  local yday=$(gdate -d "yesterday" +%Y/%m-%d)
  local dir="${HOME}/journal/${yday}"
  if [ -d "${dir}" ]; then
    cd "${dir}"
  else
    echo "Directory for previous day does not exist."
  fi
}

function mk-next() {
  local tmrw=$(gdate -d "tomorrow" +%Y/%m-%d)
  local dir="${HOME}/journal/${tmrw}"
  if [ -d "${dir}" ]; then
    cd "${dir}"
  else
    echo "Directory for next day does not exist."
  fi
}

function mk-week() {
    local year=$(date +%Y)
    local week=$(date +%V)
    local week_dir="${year}-W${week}"
    local dir="${HOME}/blogs/weekly/${week_dir}"
    mkdir -p "${dir}"
    cd "${dir}"
}

# ----------------------------------------------------------------------------

cd-prev() {
  local current_dir=$(pwd)
  local year="${current_dir##*/journal/}"
  year="${year%%/*}"
  local month_day="${current_dir##*/}"
  local target="${year}-${month_day}"
  local counter=0
  while [ $counter -lt 1000 ]; do
    target=$(gdate -d "${target} - 1 day" +%Y-%m-%d)
    local formatted_target="${target:0:4}/${target:5}"
    local dir="${HOME}/journal/${formatted_target}"
    if [ -d "${dir}" ]; then
      cd "${dir}"
      return
    fi
    counter=$((counter + 1))
  done
  echo "Reached iteration limit. Stopped looking on ${target}"
}

cd-next() {
  local current_dir=$(pwd)
  local year="${current_dir##*/journal/}"
  year="${year%%/*}"
  local month_day="${current_dir##*/}"
  local target="${year}-${month_day}"
  local counter=0
  while [ $counter -lt 1000 ]; do
    target=$(gdate -d "${target} + 1 day" +%Y-%m-%d)
    local formatted_target="${target:0:4}/${target:5}"
    local dir="${HOME}/journal/${formatted_target}"
    if [ -d "${dir}" ]; then
      cd "${dir}"
      return
    fi
    counter=$((counter + 1))
  done
  echo "Reached iteration limit. Stopped looking on ${target}"
}

# ----------------------------------------------------------------------------

if [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
    source /usr/local/etc/profile.d/bash_completion.sh
elif [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
    source "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

# Set up bash completion and key bindings for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Invoke completion
if [ -f ~/.invoke-completion.sh ]; then
    source ~/.invoke-completion.sh
fi

# https://iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

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
