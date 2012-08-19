#!/bin/bash -x

function link()
{
    ln -sf "${PWD}/$1" "$HOME/.$1"
}

# directories
[ ! -d ~/.vim ] && link vim
[ ! -d ~/.emacs.d ] && link emacs.d

# files
link bash_profile
link bash_aliases
link bashrc
link gitconfig
link gitignore
link inputrc
link irbrc
link screenrc
link tmux.conf
link urlview
link vimrc
link zshrc

