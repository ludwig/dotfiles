" ~/.vimrc
"
" Plugin Manager: https://github.com/junegunn/vim-plug
"
" To install, run this command
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" -----------------------------------------------------------------------------

" Change the mapleader from \ to ,
let mapleader=","

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Install Plugins {{{

" ack.vim - Plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'

" BufExplorer Plugin for Vim
Plug 'jlanzarotta/bufexplorer'

" NERDTree
Plug 'preservim/nerdtree'

" Plugin for clang-format
Plug 'rhysd/vim-clang-format'

" Plugin for defining operators easily
Plug 'kana/vim-operator-user'

" }}}

" Initialize plugin system
call plug#end()

" Load some default settings
source ~/.vim/defaults.vim

" Configure Plugins {{{

" --- Ack settings {{{

cabbrev ack Ack

" Search for a pattern using Ack (the trailing space is important)
nnoremap ,s :Ack! 
nnoremap ,S :Ack! <C-R>=expand("<cword>")<CR>

" Same, but use the location list window instead of the quickfix list window
nnoremap \s :LAck! 
nnoremap \S :LAck! <C-R>=expand("<cword>")<CR>

" }}}
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

" See https://superuser.com/questions/184844/hide-certain-files-in-nerdtree
"set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
"let NERDTreeRespectWildIgnore=1

" }}}
" --- vim-clang-format settings

"let g:clang_format#style_options = {
"    \ "AccessModifierOffset" : -4,
"    \ "AllowShortIfStatementsOnASingleLine" : "true",
"    \ "AlwaysBreakTemplateDeclarations" : "true",
"    \ "Standard" : "C++11"}

" Map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" If you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

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

" -----------------------------------------------------------------------------
" vim: fen fdl=0 fdm=marker
