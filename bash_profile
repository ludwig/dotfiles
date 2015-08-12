# ~/.bash_profile: executed by bash(1) for login shells

# Put the Homebrew /usr/local paths ahead in PATH
PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
MANPATH="/usr/local/share/man:${MANPATH}"

# Include ~/.bashrc if it exists.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Look for npm
if [ -e /usr/local/bin/npm ]; then
    PATH="${PATH}:/usr/local/share/npm/bin"
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
    LD_LIBRARY_PATH="${HOME}/opt/local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    PKG_CONFIG_PATH="${HOME}/opt/local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
fi

# Set up oxbot
# https://wiki.corp.openx.com/display/TECH/OXbot+Quick+Installation
export OXBOT_HOME="${HOME}/ox/oxbot"
export OXBOT_CORE="${OXBOT_HOME}/oxbot-core"
if [ -d "${OXBOT_CORE}" ]; then
    PATH="${PATH}:${OXBOT_CORE}/bin"
    export PYTHONPATH="${OXBOT_CORE}/libraries${PYTHONPATH:+:$PYTHONPATH}"
fi

# Prepend ~/bin/ to the PATH
PATH="${HOME}/bin:${PATH}"

# Set up the GPG Agent
# http://fvue.nl/wiki/Debian_4.0:_Installing_gpg-agent
if [ -f ${HOME}/.gpg-agent-info ] && \
    kill -0 $(cut -d: -f 2 ${HOME}/.gpg-agent-info)
then
    # Yes, '.gpg-agent-info' points to valid gpg-agent process;
    # Indicate gpg-agent process
    GPG_AGENT_INFO=$(cat ${HOME}/.gpg-agent-info | cut -c 16-)
else
    # No, no valid gpg-agent process available;
    # Start gpg-agent
    eval $(gpg-agent --daemon --no-grab --write-env-file ${HOME}/.gpg-agent-info)
fi
export GPG_TTY=$(tty)
export GPG_AGENT_INFO

# Export any shell variables
#export PS1='\h:\w\$ '
export EDITOR='vim'
export LANG='en_US.UTF-8'
#export LD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH
#export DYLD_FRAMEWORK_PATH
export PKG_CONFIG_PATH
export PATH
export MANPATH
