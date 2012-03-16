# ~/.bash_profile: executed by bash(1) for login shells.

# Put the MacPorts /opt/local paths ahead in PATH
PATH="/opt/local/bin:/opt/local/sbin:${PATH}"
MANPATH="/opt/local/man:${HOME}/opt/local/man:${MANPATH}"

# Put the Homebrew /usr/local paths in PATH
PATH="/usr/local/bin:${PATH}"
MANPATH="/usr/local/share/man:${MANPATH}"

# Include ~/.bashrc if it exists.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Look for deal.II's shared libraries
if [ -d ~/dev/deal.II ]; then
    # It looks funny, but ${varname:+value} evaluates to 'value' if $varname is set,
    # and to the empty string '' otherwise. We do this to avoid extraneous colon separators.
    DYLD_LIBRARY_PATH="${HOME}/dev/deal.II/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"
fi

# Look for ~/opt/local binaries and libraries
if [ -d ~/opt/local ]; then
    PATH="${HOME}/opt/local/bin:${PATH}"
    # Using the ${varname:+value} trick again.
    LD_LIBRARY_PATH="${HOME}/opt/local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    DYLD_LIBRARY_PATH="${HOME}/opt/local/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"
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
export DYLD_LIBRARY_PATH
#export DYLD_FRAMEWORK_PATH

#export CLASSPATH
export MANPATH
export PATH

