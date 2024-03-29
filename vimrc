" ~/.vimrc
" Plugin manager: vim-plug
"
" See installation instructions:
" https://github.com/junegunn/vim-plug#unix
"
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

" Change the mapleader from \ to ,
let mapleader = ","

" Let vim-plug do its thing.
" After adding new plugins, reload, and then use :PlugInstall
call plug#begin()

" Install Plugins {{{

" BufExplorer Plugin for Vim
Plug 'jlanzarotta/bufexplorer'

" NERDTree
Plug 'preservim/nerdtree'

" }}}

" Initialize the plugin system
call plug#end()

" Load some default settings
source ~/.vim/defaults.vim

" Configure Plugins {{{

" --- BufExplorer settings {{{
" To use:
"   '<Leader>be'  normal open
"   '<Leader>bs'  horizontal split open
"   '<Leader>bv'  vertical split open

let g:bufExplorerDefaultHelp=0
"let g:bufExplorerDetailedHelp=1
let g:bufExplorerFindActive=0
let g:bufExplorerShowUnlisted=0
"let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitOutPathName=1
let g:bufExplorerSplitRight=1


" }}}
" --- NERDTree settings {{{

" Toggle the NERD Tree
nmap <silent> <Leader>n :NERDTreeToggle<CR>

" Store the bookmarks
let NERDTreeBookmarksFile=expand("$HOME/.vim/tmp/NERDTreeBookmarks")

" Show the bookmarks table on startup?
let NERDTreeShowBookmarks=0

" Show hidden files?
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree?
let NERDTreeQuitOnOpen=0

" Highlight the selected entry in the tree?
let NERDTreeHighlightCursorline=0

" 1 - Double click to open nodes
" 2 - Single click to open directories, and double click to open files
" 3 - Single click to open nodes
let NERDTreeMouseMode=3

" Don't display these kinds of files
let NERDTreeIgnore=[
    \ '\.pyc$', '\.pyo$', '\.pyd$', '\.egg$',
    \ '\.class$', '\.beam$', '\.obj$', '\.o$', '\.so$', '\.a$',
    \ '^\.git$', '^\.svn$',
    \ '^__pycache__$', '^.ipynb_checkpoints$', '^.pytest_cache$'
    \ ]

" Default key to activate node is 'o'
let NERDTreeMapActivateNode='<Space>'
" }}}

" }}}

" HACK: Since Command-T doesn't have an option to filter out patterns,
" we filter out `venv` directory via `wildignore` setting.
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o,venv

" Lastly, load ~/.vim/user.vim if it exists.
" note that this file is not kept in the repository, and therefore
" we can use it to load machine-specific settings
if filereadable(expand("~/.vim/user.vim"))
    source ~/.vim/user.vim
endif

" vim: fen fdl=0 fdm=marker
