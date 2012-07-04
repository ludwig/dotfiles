Setup Instructions
==================

Clone this repository into `~/dotfiles`, and initialize the submodules::

    $ git clone git://github.com/ludwig/dotfiles.git ~/dotfiles
    $ cd ~/dotfiles
    $ git submodule init
    $ git submodule update

Now create symbolic links to our versioned dotfiles::

    $ cd $HOME
    $ ln -sf dotfiles/gitconfig ~/.gitconfig
    $ ln -sf dotfiles/gitignore ~/.gitignore
    $ ln -sf dotfiles/.bashrc ~/.bashrc
    $ ln -sf dotfiles/.bash_profile ~/.bash_profile
    $ ln -sf dotfiles/.inputrc ~/.inputrc
    $ ...

Basic Configuration Files
=========================

At the very least, I'm keeping track of the following
files::

    ~/.bash_profile
    ~/.bashrc
    ~/.vimrc
    ~/.inputrc

Repositories to follow
======================

There's a number of repositories to check out::

    http://github.com/msparks/dotfiles
    http://github.com/mislav/dotfiles
    http://github.com/dakrone/dakrone-dotfiles
    http://gitorious.org/holizz-github/dotfiles
    http://github.com/Fiona/sysconfig
    http://github.com/nvie/vimrc
    http://github.com/remiprev/vimfiles
    http://github.com/dpc/homeskel
    http://github.com/tomasr/dotfiles


Interesting Articles
====================

How I boosted my Vim::

    http://nvie.com/posts/how-i-boosted-my-vim/

Coming home to Vim::

    http://stevelosh.com/blog/2010/09/coming-home-to-vim/

Vim setup explained::

    http://writequit.org/blog/?cat=466

Write HTML faster with Sparkup::

    http://jetpackweb.com/blog/2010/03/04/write-html-faster-with-sparkup-vim-and-textmate/


.. vim: ft=rst
