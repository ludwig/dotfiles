# ~/.bash_profile: executed by bash(1) for login shells

# Put the Homebrew /usr/local paths ahead in PATH
PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
MANPATH="/usr/local/share/man:${MANPATH}"

# Include ~/.bashrc if it exists.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Look for nvm
if [ -e /usr/local/opt/nvm/ ]; then
    export NVM_DIR="${HOME}/.nvm"
    source /usr/local/opt/nvm/nvm.sh
fi

# Set our GOPATH to ~/gocode if it exists
if [ -d ~/gocode ]; then
    export GOPATH="${HOME}/gocode"
fi

# Add path for erlang man pages to MANPATH
if [ -d /usr/local/lib/erlang ]; then
    MANPATH="${MANPATH}:/usr/local/lib/erlang/man"
fi

# Look for ~/opt/local binaries and libraries
if [ -d ~/opt/local ]; then
    PATH="${HOME}/opt/local/bin:${PATH}"
    # It looks funny, but ${varname:+value} evaluates to 'value' if $varname is set,
    # and to the empty string '' otherwise. We do this to avoid extraneous colon separators.
    LD_LIBRARY_PATH="${HOME}/opt/local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    #DYLD_LIBRARY_PATH="${HOME}/opt/local/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"
    PKG_CONFIG_PATH="${HOME}/opt/local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
fi

# Look for pyenv
# https://github.com/pyenv/pyenv
# https://github.com/pyenv/pyenv-virtualenvwrapper
#if [ -e /usr/local/bin/pyenv ]; then
#    export PYENV_ROOT="${HOME}/.pyenv"
#    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
#    PATH="${PYENV_ROOT}/bin:${PATH}"
#    eval "$(pyenv init -)"
#fi

# Set up homebrew ruby
if [ -d /usr/local/opt/ruby ]; then
    PATH="/usr/local/opt/ruby/bin:$PATH"
    RUBY_LDFLAGS="-L/usr/local/opt/ruby/lib"
    #RUBY_CPPFLAGS="-L/usr/local/opt/ruby/include"
    #RUBY_PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi

# Prepend ~/bin to the PATH.
PATH="${HOME}/bin:${PATH}"

# -----------------------------------------------------------------------------
# Finally, export our shell variables
#export PS1='\u@\h:\w\$ '
export EDITOR='vim'
export PAGER='less -r'      # XXX: how does 'lesspipe' work here?
export LANG='en_US.UTF-8'

export LD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH
#export DYLD_FRAMEWORK_PATH

export PKG_CONFIG_PATH
#export CLASSPATH
export MANPATH
export PATH

if false; then
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
fi
