# ~/.bash_aliases: This file is meant to be sourced from ~/.bashrc

###############################################################################
# Commonly used aliases

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias df='df -h'
alias less='less -r'
alias vm='vim -X'
alias x='exit'

# Useful aliases for adding journal entries
alias mk-today='mkdir -p ~/journal/$(date +%Y/%m-%d) && cd ~/journal/$(date +%Y/%m-%d)'
alias mk-month='mkdir -p ~/journal/$(date +%Y/%m) && cd ~/journal/$(date +%Y/%m)'
alias mk-year='mkdir -p ~/journal/$(date +%Y) && cd ~/journal/$(date +%Y)'

function jj() { cd `journal.py prev`; }
function kk() { cd `journal.py next`; }

###############################################################################
# Other useful aliases

# Sourcing python virtualenv scripts
#alias activate-django='source ~/v/django-env/bin/activate && source ~/dev/django/extras/django_bash_completion'

# print a list of all open files
alias list-open-files="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u"

# Some ack aliases
# http://news.ycombinator.com/item?id=1021109
alias aack='ack --all'
alias rack='ack --ruby --follow'
alias fack='ack --actionscript --follow'
alias jack='ack --js'
alias pack='ack --python'

# ruby interpreter
alias irb='irb --readline -r irb/completion'

# cgoban3
alias cgoban3='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'


###############################################################################
# Platform-specific aliases

if [[ $platform == 'linux' ]]; then

    # Linux aliases
    alias ls='ls --color -F'

    # some ls aliases
    #alias ll='ls -l'
    #alias la='ls -A'
    #alias l='ls -CF'

    # misc aliases
    alias xboard-medium='xboard -size medium'
    alias xboard-fics='xboard-medium -ics -icshost freechess.org'
    alias mplayer-max='mplayer -fs -zoom -loop 0'
    alias keynote='~/.wine/drive_c/Program\ Files/KeyNote/keynote.exe 2>/dev/null'

    # http://www.masaokitamura.com/2009/02/how-to-get-yesterdays-date-using-bash-shell-scripting/
    alias cd-yesterday='cd ~/journal/$(date -d "1 day ago" +%Y/%m-%d)'

elif [[ $platform == 'macosx' ]]; then

    # Mac OS X aliases
    alias ls='ls -GF'
    alias ldd='otool -L'
    alias units='gunits -v'
    alias tree='tree -CF'
    alias md5sum='md5 -r'

    # this alias requires "port install launch"
    alias l='launch'

    # this alias needs MacVim
    alias g='mvim --remote-silent'

    # why is date different on OS X????
    # http://stackoverflow.com/questions/498358/how-do-i-do-date-math-in-a-bash-script-on-os-x-leopard
    alias cd-yesterday='cd ~/journal/$(date -v -1d +%Y/%m-%d)'

    # http://news.ycombinator.com/item?id=1157864
    alias eject='hdiutil eject'
    alias cpwd='pwd | xargs echo -n | pbcopy'
    alias apinfo='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I'

    # needs gitbox - http://gitbox.pierlis.com/
    alias gitbox="open -a Gitbox"

    # for sys-setup/scripts
    alias sd="~/p/linode/sys-setup/scripts/sys-diff.sh"

    # Emacs daemon on Mac OS X
    # http://www.emacswiki.org/emacs/EmacsAsDaemon
    # http://cubiclemuses.com/cm/articles/2009/08/06/emacs-and-os-x-launchd/
    #alias emacs='/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs'
    #alias emacsclient='/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient'
    #alias emacs.daemon='emacs --daemon'
    #alias emacs.killdaemon="emacsclient -e '(kill-emacs)'"
    #alias emacs.new='emacsclient -c -n'
    #alias emacs.open='emacsclient -n'
    #alias emacs.tty='emacsclient -t'
fi


###############################################################################
# vim: syntax=sh
