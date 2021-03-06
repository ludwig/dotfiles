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

# ----------------------------------------------------------------------------
# Finally, export our shell variables

export EDITOR='vim'
export PAGER='less -r'
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export PATH

# ----------------------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/luis/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/luis/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/luis/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/luis/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
