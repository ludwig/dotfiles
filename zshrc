# ~/.zshrc

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

PS1=$'%F{def}%(?..%B%K{red}[%?]%K{def}%b )%(1j.%b%K{yel}%F{bla}%jJ%F{def}%K{def} .)%F{white}%B%*%b %F{m}%m:%F{white}%~ %(!.#.>) %F{def}'
PS1='%F{def}%n@%m:%F{blue}%~%F{def}$ '

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30


# The following lines were added by compinstall
zstyle :compinstall filename '/Users/luis/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
alias ls='ls -GF'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -pi'
alias x='exit'

