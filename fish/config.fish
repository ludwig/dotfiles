# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------
# Aliases {{{

alias ls='ls -GF'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -ip'
alias df='df -h'
alias less='less -r'
alias x='exit'

# }}}
# Settings {{{

# cwd color (default green)
set fish_color_cwd blue

# }}}
# Configure oh-my-fish {{{

# Path to oh-my-fish
set fish_path $HOME/.oh-my-fish

# Theme
#   Some good ones: gitstatus numist robbyrussell yimmy
set fish_theme ludwig1024

# Load plugins.
#   List of plugins can be found in ~/.oh-my-fish/plugins/*
#   Custom plugins can be added to ~/.oh-my-fish/custom/plugins
set fish_plugins autojump bak vi-mode vundle

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish/custom

# Load oh-my-fish configuration
source $fish_path/oh-my-fish.fish

# }}}
# -----------------------------------------------------------------------------
# vim: fdm=marker fdl=0
# EOF
