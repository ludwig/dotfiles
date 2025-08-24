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
# NOTE: We might override PS1 and PROMPT_COMMAND in our ~/.bashrc_local

# Number of trailing components to retain when expanding \w and \W
export PROMPT_DIRTRIM=3

# Let's use nvimpager if it's installed
if command -v nvimpager &>/dev/null; then
    export PAGER=nvimpager
fi

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
shopt -s dotglob nocaseglob no_empty_cmd_completion

# Correct any minor spelling errors in the directory name, for the cd command>
#shopt -s cdspell

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

function mkcd-month() {
    local dir="./$(date +%Y-%m)"
    mkdir -p "${dir}"
    cd "${dir}"
}

function mkcd-today() {
    local dir="./$(date +%Y-%m-%d)"
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

prev-dir() {
    local current_dir
    current_dir="$(basename -- "$(pwd)")"

    if [[ ! ${current_dir} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Current directory name '${current_dir}' does not match YYYY-MM-DD"
        return 1
    fi

    local parent
    parent="$(dirname -- "$(pwd)")"

    # Collect sibling date-dirs via globbing (no ls; robust against aliases)
    local -a dirs=()
    local d name
    shopt -s nullglob
    for d in "${parent}"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]; do
        [[ -d ${d} ]] || continue
        name="$(basename -- "${d}")"
        dirs+=("${name}")
    done
    shopt -u nullglob

    if (( ${#dirs[@]} == 0 )); then
        echo "No sibling YYYY-MM-DD directories found in '${parent}'."
        return 1
    fi

    # Sort lexicographically (works for YYYY-MM-DD)
    local sorted
    sorted="$(printf '%s\n' "${dirs[@]}" | LC_ALL=C sort)"
    dirs=()
    while IFS= read -r name; do
        [[ -n ${name} ]] && dirs+=("${name}")
    done <<< "${sorted}"

    # Find current index
    local idx=-1 i
    for i in "${!dirs[@]}"; do
        if [[ ${dirs[${i}]} == "${current_dir}" ]]; then
            idx=${i}
            break
        fi
    done

    if (( idx <= 0 )); then
        echo "No previous directory found before '${current_dir}'."
        return 1
    fi

    cd -- "${parent}/${dirs[$((idx-1))]}"
}

next-dir() {
    local current_dir
    current_dir="$(basename -- "$(pwd)")"

    if [[ ! ${current_dir} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Current directory name '${current_dir}' does not match YYYY-MM-DD"
        return 1
    fi

    local parent
    parent="$(dirname -- "$(pwd)")"

    local -a dirs=()
    local d name
    shopt -s nullglob
    for d in "${parent}"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]; do
        [[ -d ${d} ]] || continue
        name="$(basename -- "${d}")"
        dirs+=("${name}")
    done
    shopt -u nullglob

    if (( ${#dirs[@]} == 0 )); then
        echo "No sibling YYYY-MM-DD directories found in '${parent}'."
        return 1
    fi

    local sorted
    sorted="$(printf '%s\n' "${dirs[@]}" | LC_ALL=C sort)"
    dirs=()
    while IFS= read -r name; do
        [[ -n ${name} ]] && dirs+=("${name}")
    done <<< "${sorted}"

    local idx=-1 i
    for i in "${!dirs[@]}"; do
        if [[ ${dirs[${i}]} == "${current_dir}" ]]; then
            idx=${i}
            break
        fi
    done

    if (( idx < 0 || idx >= ${#dirs[@]} - 1 )); then
        echo "No next directory found after '${current_dir}'."
        return 1
    fi

    cd -- "${parent}/${dirs[$((idx+1))]}"
}

# ----------------------------------------------------------------------------

cd-env() {
    # TODO: Pass environment as argument to function.
    # TODO: Tab completion for the environment name argument (just one arg)
    local env_dir
    env_dir=$(conda info --json | jq -r .active_prefix)
    if [[ -n "${env_dir}" && "${env_dir}" != "null" ]]; then
        cd "${env_dir}" || echo "Failed to cd into active conda env directory."
    else
        echo "$(tput setaf 1)No Conda environment is currently active.$(tput sgr0)"
    fi
}

cd-random() {
    local dirs
    IFS=$'\n' read -r -d '' -a dirs < <(find . -mindepth 1 -maxdepth 1 -type d -printf '%P\n' && printf '\0')

    if [[ ${#dirs[@]} -eq 0 ]]; then
        echo "No subdirectories found."
        return 1
    fi

    local random_index=$(( RANDOM % ${#dirs[@]} ))
    local target="${dirs[$random_index]}"

    cd "$target"
}

# ----------------------------------------------------------------------------

ssh-eval-keychain() {
    if ! command -v keychain &> /dev/null; then
        echo "Error: keychain command not found"
        echo "Install with homebrew or from https://www.funtoo.org/Keychain"
        return 1
    fi
    eval $(keychain --eval id_rsa)
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
