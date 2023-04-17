# ~/.bash_profile: executed by bash(1) for login shells.

# Include ~/.bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Prepend ~/bin to the PATH
if [ -d ~/bin ]; then
    PATH="${HOME}/bin:${PATH}"
fi

# Prepend python's `site.USER_BASE` bin directory to the PATH.
# On Linux, it should be ~/.local/bin
# On MacOS, it should be something like ~/Library/Python/3.7/bin
py3_user_base=$(python3 -m site --user-base)
if [[ -d ${py3_user_base} ]]; then
    PATH="${PATH}:${py3_user_base}/bin"
fi

# Prepend sbin directory to PATH.
PATH="/usr/local/sbin:${PATH}"

# Some systems don't use /usr/local for homebrew.
if [[ -d /opt/homebrew ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# ----------------------------------------------------------------------------
# Finally, export our shell variables

export EDITOR='vim'
export PAGER='less -r'
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export PATH

# ----------------------------------------------------------------------------
