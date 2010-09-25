#!/bin/sh
#
# See http://github.com/nvie/vimrc/blob/master/vim/bundle/check_for_updates.sh
# 
# Alternatively, use these commands at the root of the repo:
#
#   cd ~/dotfiles
#   git submodule init
#   git submodule update
#

oldcwd=$(pwd)

cd $(dirname "$0")
for submodule in *; do
    if [ -d "$submodule/.git" ]; then
        cd "$submodule"
        echo "--- $submodule:"
        git pull
        cd ..
    fi
done

cd "$oldcwd"
