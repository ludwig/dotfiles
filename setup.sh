#!/bin/bash
# By default, let's quit right away.
exit 1

# Assuming we've checked out this repo under ~/dotfiles
# we can then copy/paste the desired symlinks below into
# another terminal. I've grouped them roughly in order
# of importance.

ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/inputrc ~/.inputrc

ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore ~/.gitignore

ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/screenrc ~/.screenrc
ln -sf ~/dotfiles/ackrc ~/.ackrc
ln -sf ~/dotfiles/condarc ~/.condarc

ln -sf ~/dotfiles/urlview ~/.urlview
ln -sf ~/dotfiles/tigrc ~/.tigrc
