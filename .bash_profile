# ~/.bash_profile: executed by bash(1) for login shells.

# Put the MacPorts /opt/local paths ahead in PATH
PATH="/opt/local/bin:/opt/local/sbin:$PATH"
MANPATH="/opt/local/man:${HOME}/opt/local/man:${MANPATH}"

# Place /usr/local/bin ahead in PATH
PATH="/usr/local/bin:$PATH"

# Prepend my ~/bin and ~/opt/local/bin dirs to the PATH
# and add ~/opt/local/lib to my library paths
PATH="${HOME}/bin:${HOME}/opt/local/bin:${PATH}"
LD_LIBRARY_PATH="${HOME}/opt/local/lib:${LD_LIBRARY_PATH}"
DYLD_LIBRARY_PATH="${HOME}/opt/local/lib:${DYLD_LIBRARY_PATH}"

# Include ~/.bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

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

