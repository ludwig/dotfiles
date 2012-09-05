" ~/.vimrc
" Inspired by
"   https://github.com/nvie/vimrc/
"   https://github.com/mutewinter/dot_vim

" Use vim settings, rather than vi settings
" This must be first, because it changes other options as a side effect
set nocompatible

" Change the mapleader from \ to ,
let mapleader=","

" -----------------------------------------------------------------------------
" Plugin Settings

" Vundle Plugin Manager {{{

" Use vundle to modify the runtime path for including all plugins
" under the ~/.vim/bundle/ directory
"
" To bootstrap vundle, run:
"   $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" Brief help
"   :BundleList             - list configured bundles
"   :BundleInstall(!)       - install (update) bundles
"   :BundleSearch(!) foo    - search (or refresh cache first) for foo
"   :BundleClean(!)         - confirm (or auto-approve) removal of unused bundles
"
" See ':h vundle' for more details, or wiki for FAQ
"

filetype off    " required!

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required!)
" https://github.com/gmarik/vundle/
Bundle 'gmarik/vundle'

" Plugin Bundles
" --- Navigation {{{

" ZoomWin - Zoom in/out of windows (toggle between one window and multi-window)
" Use '<C-w>o' to toggle zoom on window
" http://www.vim.org/scripts/script.php?script_id=508
Bundle 'ZoomWin'

" Command-T - Fast file navigation for vim
" http://www.vim.org/scripts/script.php?script_id=3025
" https://github.com/wincent/Command-T
" http://git.wincent.com/command-t.git
"Bundle 'wincent/Command-T'
Bundle 'git://git.wincent.com/command-t.git'

" space.vim - Smart Space key for vim
" https://github.com/spiiph/vim-space
" https://github.com/christoomey/vim-space
" https://github.com/spiiph/vim-space/blob/master/doc/space.txt
"Bundle 'spiiph/vim-space'

" EasyMotion - Vim motions on speed!
" http://www.vim.org/scripts/script.php?script_id=3526
" https://github.com/Lokaltog/vim-easymotion
Bundle 'Lokaltog/vim-easymotion'

" LustyJuggler - Switch very quickly among your active buffers
" Launch with '<Leader>lj'
" http://www.vim.org/scripts/script.php?script_id=2050
" https://github.com/sjbach/lusty
" https://github.com/vim-scripts/LustyJuggler
" https://github.com/mutewinter/LustyJuggler
Bundle 'LustyJuggler'

" ctrlp.vim - Fuzzy file, buffer, mru, tag, ... finder with regexp support
" http://www.vim.org/scripts/script.php?script_id=3736
" https://github.com/kien/ctrlp.vim
Bundle 'kien/ctrlp.vim'

" }}}
" --- UI Additions {{{

" NERDTree - Tree explorer plugin
" http://www.vim.org/scripts/script.php?script_id=1658
" https://github.com/scrooloose/nerdtree/
Bundle 'scrooloose/nerdtree'

" Powerline - The ultimate vim statusline utility
" http://www.vim.org/scripts/script.php?script_id=3881
" https://github.com/Lokaltog/vim-powerline
Bundle 'Lokaltog/vim-powerline'

" Indent Guides - A plugin for visually displaying indent levels in Vim
" http://www.vim.org/scripts/script.php?script_id=3361
" https://github.com/nathanaelkane/vim-indent-guides
" https://github.com/mutewinter/vim-indent-guides
" http://nathanaelkane.imgur.com/indent_guides
Bundle 'nathanaelkane/vim-indent-guides'

" colorv.vim - Easier color handling
" Use with '<Leader>ce'
" http://www.vim.org/scripts/script.php?script_id=3597
" https://github.com/Rykka/colorv.vim
Bundle 'Rykka/colorv.vim'

" quickfixsigns - Mark quickfix & location list items with signs
" http://www.vim.org/scripts/script.php?script_id=2584
" https://github.com/tomtom/quickfixsigns_vim
"Bundle 'tomtom/quickfixsigns_vim'

" tagbar - Vim plugin that displays tags in a window, ordered by class etc.
" http://majutsushi.github.com/tagbar/
" http://www.vim.org/scripts/script.php?script_id=3465
" https://github.com/majutsushi/tagbar
Bundle 'majutsushi/tagbar'

" taglist.vim - Source code browser (supports C, C++, java, python, etc.)
" http://www.vim.org/scripts/script.php?script_id=273
Bundle 'taglist.vim'

" gitv - gitk for vim
" http://www.gregsexton.org/portfolio/gitv/
" http://www.vim.org/scripts/script.php?script_id=3574
" https://github.com/gregsexton/gitv
Bundle 'gregsexton/gitv'

" splice.vim - plugin for managing three-way merges
" http://vimeo.com/25764692
" http://sjl.bitbucket.org/splice.vim/
" https://github.com/sjl/splice.vim
" http://www.vim.org/scripts/script.php?script_id=4026
"Bundle 'sjl/splice.vim'

" molokai - a port of the monokai scheme for TextMate
" http://www.vim.org/scripts/script.php?script_id=2340
" https://github.com/tomasr/molokai
Bundle 'tomasr/molokai'

" badwolf - a vim color scheme
" https://github.com/sjl/badwolf
Bundle 'sjl/badwolf'

" jellybeans.vim - Colorful, dark color scheme
" http://www.vim.org/scripts/script.php?script_id=2555
" https://github.com/nanotech/jellybeans.vim
Bundle 'nanotech/jellybeans.vim'

" vim-colors-solarized - precision color scheme for vim
" https://github.com/altercation/vim-colors-solarized
Bundle 'altercation/vim-colors-solarized'

" }}}
" --- Commands {{{

" NERDCommenter - Plugin that allows easy commenting of code
" http://www.vim.org/scripts/script.php?script_id=1218
" https://github.com/scrooloose/nerdcommenter
Bundle 'scrooloose/nerdcommenter'

" surround.vim - quoting/parenthesizing made simple
" http://www.vim.org/scripts/script.php?script_id=1697
" https://github.com/tpope/vim-surround
Bundle 'tpope/vim-surround'

" speeddating.vim - use CTRL-A / CTRL-X to increment dates, times, and more
" http://www.vim.org/scripts/script.php?script_id=2120
" https://github.com/tpope/vim-speeddating
Bundle 'tpope/vim-speeddating'

" fugitive.vim - a git wrapper so awesome, it should be illegal
" http://www.vim.org/scripts/script.php?script_id=2975
" https://github.com/tpope/vim-fugitive
Bundle 'tpope/vim-fugitive'

" Tabular - Vim script for text filtering and alignment
" http://www.vim.org/scripts/script.php?script_id=3464
" https://github.com/godlygeek/tabular
Bundle 'godlygeek/tabular'

" ack.vim - Plugin for the Perl module / CLI script 'ack'
" http://www.vim.org/scripts/script.php?script_id=2572
" https://github.com/mileszs/ack.vim
Bundle 'mileszs/ack.vim'

" sudo-gui.vim - sudo GUI for a GUI vim
" https://github.com/gmarik/sudo-gui.vim
Bundle 'gmarik/sudo-gui.vim'

" vim-togglelist - Functions to toggle the [Location List] and the [Quickfix List] windows
" Use '<Leader>l' to toggle the location list
" Use '<Leader>q' to toggle the quickfix list
" https://github.com/milkypostman/vim-togglelist
Bundle 'milkypostman/vim-togglelist'

" swap parameters - swap parameters of a function (requires python)
" http://www.vim.org/scripts/script.php?script_id=2032
" https://github.com/vim-scripts/swap-parameters
" https://github.com/mutewinter/swap-parameters
"Bundle 'mutewinter/swap-parameters'

" YankRing.vim - Maintains a history of previous yanks, changes, and deletes
" http://www.vim.org/scripts/script.php?script_id=1234
" https://github.com/vim-scripts/YankRing.vim
Bundle 'YankRing.vim'

" keepcase.vim - Functions for doing case-persistant substitutions
" http://www.vim.org/scripts/script.php?script_id=6
Bundle 'keepcase.vim'

" scratch.vim - plugin to create and use a scratch vim buffer
" http://www.vim.org/scripts/script.php?script_id=664
Bundle 'scratch.vim'

" ZenCoding.vim - vim plugins for HTML and CSS hi-speed coding
" http://www.vim.org/scripts/script.php?script_id=2981
" https://github.com/mattn/zencoding-vim
Bundle 'mattn/zencoding-vim'

" }}}
" --- Automatic Helpers {{{

" IndexedSearch - shows 'Nth match out of M' at every search (index of match + total num matches)
" http://www.vim.org/scripts/script.php?script_id=1682
"Bundle 'IndexedSearch'

" session.vim - extended session management for vim
" http://www.vim.org/scripts/script.php?script_id=3150
" https://github.com/xolox/vim-session
Bundle 'xolox/vim-session'

" delimitMate.vim - Provides auto-balancing and some expansions for parens, quotes, etc.
" http://www.vim.org/scripts/script.php?script_id=2754
" https://github.com/Raimondi/delimitMate
Bundle 'Raimondi/delimitMate'

" Syntastic - Automatic syntax checking
" http://www.vim.org/scripts/script.php?script_id=2736
" https://github.com/scrooloose/syntastic
"Bundle 'scrooloose/syntastic'

" SuperTab - Do all your insert-mode completion with Tab
" http://www.vim.org/scripts/script.php?script_id=1643
" https://github.com/ervandew/supertab
Bundle 'ervandew/supertab'

" MatchTag - MatchParen for HTML tags
" http://www.vim.org/scripts/script.php?script_id=3818
" https://github.com/gregsexton/MatchTag
Bundle 'gregsexton/MatchTag'

" closetag.vim - Functions and mappings to close open HTML/XML tags
" http://www.vim.org/scripts/script.php?script_id=13
" https://github.com/vim-scripts/closetag.vim
Bundle 'vim-scripts/closetag.vim'

" neocomplcache - Ultimate auto completion system for vim
" http://www.vim.org/scripts/script.php?script_id=2620
" https://github.com/Shougo/neocomplcache
Bundle 'Shougo/neocomplcache'

" }}}
" --- Snippets {{{

" snipMate - TextMate-style snippets for Vim (and dependencies)
" http://vimeo.com/3535418
" http://www.vim.org/scripts/script.php?script_id=2540
" https://github.com/garbas/vim-snipmate
" https://github.com/honza/snipmate-snippets
" https://github.com/MarcWeber/vim-addon-mw-utils
" https://github.com/tomtom/tlib_vim
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'

" snipmate_for_django - Django snippets for SnipMate
" https://github.com/robhudson/snipmate_for_django
Bundle 'robhudson/snipmate_for_django'

" }}}
" --- Language Additions {{{

" vim-ruby - Vim/Ruby Configuration Files
" https://github.com/vim-ruby/vim-ruby
Bundle 'vim-ruby/vim-ruby'

" vim-haml - Vim runtime files for Haml, Sass, and Scss
" http://www.vim.org/scripts/script.php?script_id=1433
" https://github.com/tpope/vim-haml
Bundle 'tpope/vim-haml'

" rails.vim - Ruby on Rails power tools
" http://www.vim.org/scripts/script.php?script_id=1567
" https://github.com/tpope/vim-rails
Bundle 'tpope/vim-rails'

" rake.vim - It's like rails.vim without the rails
" http://www.vim.org/scripts/script.php?script_id=3669
" https://github.com/tpope/vim-rake
Bundle 'tpope/vim-rake'

" vim-javascript - Vastly improved javascript indentation
" http://www.vim.org/scripts/script.php?script_id=2765
" https://github.com/pangloss/vim-javascript
Bundle 'pangloss/vim-javascript'

" vim-coffee-script - CoffeeScript support for vim
" http://www.vim.org/scripts/script.php?script_id=3590
" https://github.com/kchmck/vim-coffee-script
Bundle 'kchmck/vim-coffee-script'

" JSON.vim - A syntax highlighting file for JSON
" http://www.vim.org/scripts/script.php?script_id=1945
" https://github.com/leshill/vim-json
Bundle 'leshill/vim-json'

" jQuery - Syntax file for jQuery
" https://github.com/itspriddle/vim-jquery
" http://www.vim.org/scripts/script.php?script_id=2416
" https://github.com/nono/jquery.vim
Bundle 'nono/jquery.vim'

" Handlebars - Vim syntax for Handlebars
" http://www.vim.org/scripts/script.php?script_id=3638
" https://github.com/nono/vim-handlebars
Bundle 'nono/vim-handlebars'

" cocoa.vim - Plugin for Cocoa/Objective-C development
" http://www.vim.org/scripts/script.php?script_id=2674
" https://github.com/msanders/cocoa.vim
Bundle 'msanders/cocoa.vim'

" taskpaper.vim - syntax file and ftplugin for TaskPaper application
" http://www.hogbaysoftware.com/products/taskpaper
" http://www.vim.org/scripts/script.php?script_id=2027
" https://github.com/davidoc/taskpaper.vim
" https://github.com/mutewinter/taskpaper.vim
"Bundle 'davidoc/taskpaper.vim'

" nginx.vim - syntax highlighting for nginx.conf and related files
" http://www.vim.org/scripts/script.php?script_id=1886
" https://github.com/vim-scripts/nginx.vim
" https://github.com/mutewinter/nginx.vim
Bundle 'mutewinter/nginx.vim'

" Textile - Syntax highlighting for Textile
" http://www.vim.org/scripts/script.php?script_id=2305
" https://github.com/timcharper/textile.vim
Bundle 'timcharper/textile.vim'

" Markdown - Syntax highlighting for Markdown text files
" http://www.vim.org/scripts/script.php?script_id=2882
" https://github.com/hallison/vim-markdown
Bundle 'hallison/vim-markdown'

" vim-less - vim syntax for LESS (dynamic CSS)
" https://github.com/groenewege/vim-less
Bundle 'groenewege/vim-less'

" Better CSS Syntax for Vim
" https://github.com/ChrisYip/Better-CSS-Syntax-for-Vim
Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'

" VimClojure - a filetype, syntax and indent plugin for Clojure
" http://www.vim.org/scripts/script.php?script_id=2501
" https://github.com/vim-scripts/VimClojure
" https://github.com/zaiste/VimClojure
Bundle 'zaiste/VimClojure'

" }}}
" --- Libraries {{{

" L9 - vim-script library
" http://www.vim.org/scripts/script.php?script_id=3252
Bundle 'L9'

" tlib - some utility functions (needed by 'tomtom/quickfixsigns_vim')
" http://www.vim.org/scripts/script.php?script_id=1863
" https://github.com/tomtom/tlib_vim
Bundle 'tomtom/tlib_vim'

" repeat.vim - Use the repeat command (.) with supported plugins
" http://www.vim.org/scripts/script.php?script_id=2136
" https://github.com/tpope/vim-repeat
Bundle 'tpope/vim-repeat'

" }}}
" --- Misc {{{

" a.vim - alternate files quickly
" http://www.vim.org/scripts/script.php?script_id=31
Bundle 'a.vim'

" bufexplorer.zip - Buffer Explorer / Browser
" http://www.vim.org/scripts/script.php?script_id=42
" https://github.com/vim-scripts/bufexplorer.zip
Bundle 'bufexplorer.zip'

" mru.vim - manage 'Most Recently Used (MRU)' files
" http://www.vim.org/scripts/script.php?script_id=521
Bundle 'mru.vim'

" localrc.vim - enable configuration file of each directory
" http://www.vim.org/scripts/script.php?script_id=3393
" https://github.com/thinca/vim-localrc
Bundle 'localrc.vim'

" rest.vim - a reStructuredText syntax mode
" http://www.vim.org/scripts/script.php?script_id=973
Bundle 'rest.vim'

" matchit.zip - extended % matching for HTML, LaTeX, and many other languages
" http://www.vim.org/scripts/script.php?script_id=39
Bundle 'matchit.zip'

" textobj-user - Support for user-defined text objects
" http://www.vim.org/scripts/script.php?script_id=2100
" https://github.com/kana/vim-textobj-user
Bundle 'kana/vim-textobj-user'

" vim-indent-object - Text Objects based on Indentation Level
" http://www.vim.org/scripts/script.php?script_id=3037
" https://github.com/michaeljsmith/vim-indent-object
Bundle 'michaeljsmith/vim-indent-object'

" django template textobjects - textobject mappings for the django template language
" http://www.vim.org/scripts/script.php?script_id=2999
" https://github.com/mjbrownie/django-template-textobjects
Bundle 'mjbrownie/django-template-textobjects'

" textobj-rubyblock - A custom text object for selecting ruby blocks
" http://vimcasts.org/blog/2010/12/a-text-object-for-ruby-blocks/
" http://www.vim.org/scripts/script.php?script_id=3382
" https://github.com/nelstrom/vim-textobj-rubyblock
Bundle 'nelstrom/vim-textobj-rubyblock'

" Conque Shell - run interactive commands inside a vim buffer
" http://www.vim.org/scripts/script.php?script_id=2771
Bundle 'Conque-Shell'

" tmux.vim - tmux vim syntax
" http://tmux.svn.sourceforge.net/viewvc/tmux/trunk/examples/tmux.vim?revision=2783&view=markup
" https://github.com/zaiste/tmux.vim
Bundle 'zaiste/tmux.vim'

" vimux - effortless vim and tmux interaction
" To use, run :call RunVimTmuxCommand("ls")
" http://www.vim.org/scripts/script.php?script_id=4011
" https://github.com/benmills/vimux
Bundle 'benmills/vimux'

" }}}

" enable filetype detection, plugins and indenting in one step.
" must turn on after vundle setup
filetype plugin indent on

" }}}

" Configure plugins {{{
" --- a.vim settings {{{
nnoremap <silent> \s :A<CR>
nnoremap <silent> ,s :A<CR>
" }}}
" --- Ack settings {{{
cabbrev ack Ack
" }}}
" --- BufExplorer settings {{{

" To use:
"   '<Leader>be'  normal open
"   '<Leader>bs'  horizontal split open
"   '<Leader>bv'  vertical split open

" XXX: figure out how to disable the mappings starting with ,
"nmap <silent> <unique> \be :BufExplorer<CR>
"nmap <silent> <unique> \bs :BufExplorerHorizontalSplit<CR>
"nmap <silent> <unique> \bv :BufExplorerVerticalSplit<CR>

let g:bufExplorerDefaultHelp=0
"let g:bufExplorerDetailedHelp=1
"let g:bufExplorerFindActive=0
let g:bufExplorerShowUnlisted=0
"let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitOutPathName=1
let g:bufExplorerSplitRight=1

" }}}
" --- Command-T settings {{{

" To setup this plugin after installation:
"   $ cd ~/.vim/bundle/command-t/ruby/command-t
"   $ ruby extconf.rb
"   $ make

" Use '\t' to run :CommandT<CR>
nnoremap <silent> \t :CommandT<CR>

" Use '\b' to run :CommandTBuffer<CR>
nnoremap <silent> \b :CommandTBuffer<CR>

" Also use CTRL-B and CTRL-G
nnoremap <silent> <C-B> :CommandTBuffer<CR>
nnoremap <silent> <C-G> :CommandT<CR>

" }}}
" --- EasyMotion settings {{{

" Use with \\{motion-command} such as \\w, \\f, etc.
let g:EasyMotion_leader_key = '\\'

" }}}
" --- Gitv settings {{{

" See https://github.com/gregsexton/gitv

cabbrev git Git
cabbrev gitv Gitv

nmap <leader>gv :Gitv --all<CR>
nmap <leader>gV :Gitv! --all<CR>

" }}}
" --- IndentGuides settings {{{

" Toggle this plugin with '<Leader>ig' -- runs :IndentGuidesToggle
let g:indent_guides_color_change_percent = 10
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 0

" }}}
" --- LustyJuggler settings {{{

" Use '<Leader>lj' to run :LustyJuggler
let g:LustyJugglerDefaultMappings = 1

" Disable LustyJuggler warning (default vim not built with ruby)
"let g:LustyJugglerSuppressRubyWarning = 1

" }}}
" --- MRU settings {{{

" Open list of most recently used files with ':MRU' or ',m'
nmap <silent> <Leader>m :MRU<CR>

" }}}
" --- NERDTree settings {{{

" Toggle the NERD Tree
nmap <Leader>n :NERDTreeToggle<CR>

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

" Use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[
    \ '\.pyc$', '\.pyo$', '\.py$', '\.egg$',
    \ '\.class$', '\.obj$', '\.o$', '\.so$',
    \ '^\.git$', '^\.svn$' ]

" }}}
" --- NERDCommenter settings {{{

" Mappings
"   ',cu'   uncomments
"   ',cc'   comments out lines
"   ',cl'   aligns delimiters on left
"   ',cb'   aligns delimiters on right
"   ',cs'   uses sexy delimiters

let NERDCommentWholeLinesInVMode=2

let NERDSpaceDelims=0

" }}}
" --- scratch.vim settings {{{
cabbrev scratch Scratch
cabbrev sscratch Sscratch
nmap <leader><tab> :Sscratch<CR><C-w>x<C-w><C-j>i
" }}}
" --- TagList settings {{{

" Toggle TagList with ',T'
nmap <silent> <leader>T :TlistToggle<CR>

let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files
"set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}
" --- Tagbar settings {{{
" Toggle Tagbar with ',t'
nmap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 99
" }}}
" --- Tabular settings {{{

" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
"if exists(":Tabularize")
"    nmap \a= :Tabularize /=<CR>
"    vmap \a= :Tabularize /=<CR>
"    nmap \a: :Tabularize /:\zs<CR>
"    vmap \a: :Tabularize /:\zs<CR>
"endif

" }}}
" --- YankRing settings {{{

let g:yankring_history_dir = '$HOME/.vim/tmp'
nmap <leader>r :YRShow<CR>

" }}}
" --- Conflict markers {{{

" XXX: Do we even use these? See if we can get rid of this section...
if 0
    " highlight conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " shortcut to jump to next conflict marker
    nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
endif

" }}}
" --- Skeleton processing {{{

" See also: http://stackoverflow.com/questions/162617/how-can-i-automatically-add-some-skeleton-code-when-creating-a-new-file-with-vim

if has("autocmd")

    if !exists('*LoadTemplate')
        function LoadTemplate(file)
            if a:file =~ 'furls$'
                execute "0r ~/.vim/skeleton/furls"
                execute "normal Gddgg"
                set ft=conf
            elseif a:file =~ 'furls2$'
                execute "0r ~/.vim/skeleton/furls2"
                set ft=conf
            endif
        endfunction
    endif

    autocmd BufNewFile * call LoadTemplate(@%)

endif

" }}}
" }}}

" -----------------------------------------------------------------------------
" Vim Settings

" Editing behaviour {{{

set showmode                    " always show what mode we're currently editing in
set expandtab                   " expand tabs into spaces by default (overloadable per file type later)
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set showmatch                   " show matching parenthesis
set smartcase                   " ignore case if search pattern is all lowercase (case-sensitive otherwise)
set scrolloff=1                 " keep N lines off the edges of the screen when scrolling
set sidescrolloff=1             " ditto, for horizontal scrolling
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace 'globally' (on a line) by default

"set nowrap                      " don't wrap lines
"set smartindent                 " use smart autoindenting when starting a new line
"set number                      " always show line numbers
"set ignorecase                  " ignore case when searching
"set virtualedit=all             " allow the cursor to go to 'invalid' places
"set cursorline                  " highlight current line (or not)

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" don't show invisible characters by default, but it is enabled for some filetypes (see later)
set nolist

" strings to use in 'list' mode for the :list command
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
"set listchars+=eol:¬

" Don't add empty newlines at the end of files
set noeol

" when in insert mode, press <F2> to go to paste mode, where you
" can paste mass data that won't be autoindented
set pastetoggle=<F2>

" specifies what end-of-line formats will be tried when editing a new buffer
set fileformats="unix,dos,mac"

" don't show the intro message when starting vim
set shortmess=atI

" don't reset cursor to start of line when moving around
set nostartofline

" don't beep
set visualbell
set noerrorbells

" show (partial) command in the last line of the screen.
" this also shows visual selection info
set showcmd

" modeline settings (disable mode lines, as security measure)
set modelines=5
set modeline

" always use a fast terminal
set ttyfast

" enable using the mouse if terminal emulator supports it (xterm does)
set mouse=a

" when on, splitting a window will put the new window right of the current one
set nosplitright

" when on, splitting a window will put the new window below the current one
set nosplitbelow

" hide buffers instead of closing them. this means that the current buffer
" can be put to background without being written; and that marks and undo
" history are preserved
set hidden

" }}}

" Vim behaviour {{{

" change the terminal's title
set title

" reveal already opened files from the quickfix window instead
" of opening new buffers
set switchbuf=useopen

" Set this when editing binary files (note: expandtab is turned off!)
"set binary

" remember more commands and search history
set history=1000
set undolevels=1000

" read/write a .viminfo file, don't store more than 80 lines of registers
set viminfo='20,\"80

" We typically don't want to use the current working directory as a backupdir.
" Fortunately, we can set it explicitly. See the following Vim FAQ entry:
" http://vimdoc.sourceforge.net/cgi-bin/vimfaq2html3.pl#7.2
" See also: http://news.ycombinator.com/item?id=1688068
set backupdir=~/.vim/tmp//,~/tmp//,/tmp//
set directory=~/.vim/tmp//,~/tmp//,/tmp//

" keep the undo history for our buffers (disable for now)
if 0 && exists('+undofile')
    set undofile
    set undodir=~/.vim/tmp//,~/tmp//,/tmp//
endif

" make tab completion for files/buffers act like bash
set wildmenu

" show a list when pressing tab, and complete first full match
set wildmode=list:full

" ignore completion for these files
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o

" underline the current line, for quick orientation
"set cursorline

" Tame the quickfix window (open/close using ,f)
nmap <silent> <leader>f :QFix<CR>
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" }}}

" Folding rules {{{

"set foldenable                  " enable folding
"set foldcolumn=2                " add a fold column

set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded

" which commands trigger auto-unfold
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" customize the text displayed for a closed fold
set foldtext=MyFoldText()
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction

" }}}

" Editor layout {{{
set termencoding=utf-8          " character encoding used for the terminal
set encoding=utf-8              " character encoding used inside vim
set lazyredraw                  " don't update the display while executing macros
set cmdheight=1                 " use a statusbar that is 2 rows high (nevermind, set it back to 1)
set showtabline=1               " show tab page labels (0 = never, 1 = when more than one, 2 = always)
set laststatus=2                " tell VIM to always put a status line in, even if there is only one window
set ruler                       " show line and column number of the cursor position
" }}}

" Highlighting {{{

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

if &t_Co >= 256 || has("gui_running")
    " other colorschemes:
    "   default, molokai, badwolf, jellybeans, herald, inkpot,
    "   tir_black, gardener, desert256, calmar256-dark, calmar256-light,
    "   Tomorrow, Tomorrow-Night, Tomorrow-Night-Bright,
    "   Tomorrow-Night-Eighties
    colorscheme default
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

" Highlighting the 80th column (or relative to 'textwidth')
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
" http://vim.wikia.com/wiki/VimTip810
if 0 && exists('+colorcolumn')
    "set colorcolumn=+0
    set colorcolumn=80
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
    " see ':help match'
    match OverLength /\%81v.\+/
endif

" }}}

" Mappings and keybindings {{{

" Use the damn hjkl keys already
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped lines
nnoremap j gj
nnoremap k gk

" Use normal regexes in search (instead of vim's crazy regexes)
" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Scroll one line at a time with C-j / C-k, in normal mode.
" To scroll by half a page, use the usual CTRL-U / CTRL-D.
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Similarly for incremental horizontal scrolling (useful with ':set nowrap').
" Although, is it really a good idea to override CTRL-L, which typically
" refreshes the screen?
nnoremap <C-h> 3zh
nnoremap <C-l> 3zl

" Use CTRL-C
map <C-c> <Esc>

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Shortcut to make
nmap mk :make<CR>

" Swap implementations of ` and ' jump to markers.
" By default, ' jumps to the marked line, ` jumps to the mark line and column.
" So, swap them.
nnoremap ' `
nnoremap ` '

" Easy window navigation (disable for now)
" Actually, the original keybindings aren't so bad. It's better to save
" the C-hjkl keybindings for scrolling.
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
"nnoremap <leader>w <C-w>v<C-w>l

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Quick yanking to the end of the line
nmap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" Edit the vimrc file
"nmap <silent> <leader>ev :e $MYVIMRC<CR>
"nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
"inoremap jj <Esc>
"inoremap jk <Esc>

" Quick alignment of text
"nmap <leader>al :left<CR>
"nmap <leader>ar :right<CR>
"nmap <leader>ac :center<CR>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :Ack 

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" }}}

" Filetype specific handling {{{

" only do this part when compiled with support for autocommands
if has("autocmd")

    augroup invisible_chars "{{{
        au!
        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!
        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!
        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        " http://mirnazim.org/writings/vim-plugins-i-use/
        autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
        autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

        " Enable Sparkup for lightning-fast HTML editing
        let g:sparkupExecuteMapping = '<leader>e'
    augroup end "}}}

    augroup python_files "{{{
        au!
        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        "autocmd filetype python match ErrorMsg '\%>79v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
        " (this action is also mapped to <F7> by default)
        "autocmd BufWritePost *.py call Pyflakes()
    augroup end "}}}

    augroup ruby_files "{{{
        au!
        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end "}}}

    augroup rst_files "{{{
        au!
        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        "autocmd filetype rst match ErrorMsg '\%>73v.\+'
    augroup end "}}}

    augroup css_files "{{{
        au!
        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!
        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}

endif

" }}}

" Suggestions from Reddit and HN {{{

" From http://www.reddit.com/r/vim/comments/e341j/time_for_a_vim_tricks_thread_please_search_before/

" Python filter
vmap gp :!python<CR>

" reselect visual block after changing its indent
vnoremap < <gv
vnoremap > >gv

" move current line up
nnoremap <A-k> :m-2<cr>
" move current line down
nnoremap <A-j> :m+<cr>
" move visual selection up
vnoremap <A-k> :m-2<cr>gv
vnoremap <A-j> :m'>+<cr>gv

" Window mappings 
set winminheight=0

" Adding the control keys to hjkl jump to the window and make it full screen
"nmap <C-j> <C-w>j<C-w>_
"nmap <C-k> <C-w>k<C-w>_

" Move between windows using arrow keys
"nnoremap <left>  <C-w>h
"nnoremap <right> <C-w>l
"nnoremap <up>    <C-w>k
"nnoremap <down>  <C-w>j

" Instead, use these arrow key mappings
"nnoremap <left>     B
"nnoremap <right>    E
"nnoremap <up>       {
"nnoremap <down>     }

" Move between tabs using shifted arrow keys
"nnoremap <S-left>  gT
"nnoremap <S-right> gt

" Keep search pattern at the center of the screen
" http://vimbits.com/bits/92
" XXX: resolve conflicts with nerdtree
"nnoremap <leader>n nzz
"nnoremap <leader>N Nzz

" tabnew shortcuts
" http://www.reddit.com/r/vimcommands/comments/kbheh/tabnew/
nmap ,, :tabnew<CR>
nmap ,. :tabnext<CR>
nmap ., :tabprev<CR>

" What is the syntax name for the thing under my cursor?
" Useful for debugging syntax highlighting
" To use, type ":echo SyntaxItem()" at the cursor location
function! SyntaxItem()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" How to define custom colored labels (like TODO) in VIM
" http://dtuite.github.com/define-custom-vim-tags-and-labels.html
" http://news.ycombinator.com/item?id=3037161
" TODO: use the above

" }}}

" Miscellaneous settings {{{

" Don't let cindent muck with ':' in insert-mode.
set cinkeys-=:

" when changing a line, don't redisplay, but put a '$' at the end during the change
set cpoptions+=$

" don't start new lines w/ comment leader on pressing 'o'
set formatoptions-=o

" somehow, during vim filetype detection, this gets set for vim files,
" so explicitly unset it again
au filetype vim set formatoptions-=o

" Program to use for formatting text
" 'gqip' formats paragraph using external tool specified in 'formatprg'
" 'gwip' formats paragraph using vim's internal formatting tool
" see 'par help' at the command line for available options
" http://vimcasts.org/episodes/formatting-text-with-par/
set formatprg=par
"set formatprg=par\ w50
"set formatprg=par\ w50req
"set formatprg=par\ w72p3qrf

" to enable automatic text wrapping use these settings (leave them commented out here)
"set textwidth=80
"set formatoptions+=t

" Disable keyword lookup in normal mode. Note that K will still work in visual mode,
" using vawK sequence, for example.
nmap K <nop>

" Program to use for keyword lookups (default is "man -s")
set keywordprg=man\ -s

" Load alternate file (swap between header and implementation).
" Can also use CTRL-^ for this.
nmap <silent> \s :A<CR>

" Common abbreviations / misspellings
source ~/.vim/autocorrect.vim

" Restore cursor position upon reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Configure graphical vim
if has("gui_running")
    " Disable gui toolbar
    set guioptions-=T
endif

" Horizontal rule separator (80 characters wide)
function! HorizontalRule()
    let @s = "-------------------------------------------------------------------------------"
    put s
endfunction
nnoremap <silent> <leader>hr :call HorizontalRule()<CR>

" Function for hiding line comments
" http://www.debian-administration.org/article/616/Hiding_comments_in_configuration_files
function! HideLineComments()
    set foldmethod=expr
    set foldexpr=getline(v:lnum)=~'^\\s*//'?1:getline(prevnonblank(v:lnum))=~'^\\s*//'?1:getline(nextnonblank(v:lnum))=~'^\\s*//'?1:0
    highlight clear Folded
    highlight link Folded ignore
    normal zM
endfunction
nnoremap <silent> <leader>hc :call HideLineComments()<CR>

" Function for hiding block comments
" http://www.linuxquestions.org/questions/linux-general-1/vim-plugin-for-hiding-block-comments-466625/
function! HideBlockComments()
    set foldmethod=marker
    set foldmarker=/*,*/
    highlight clear Folded
    highlight link Folded ignore
    normal zM
endfunction
nnoremap <silent> <leader>hb :call HideBlockComments()<CR>

" Creating underline/overline headings for markup languages
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

" Filler text
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" }}}

" Extra user or machine specific settings {{{

" disable the substitute commands
nnoremap s <nop>
nnoremap S <nop>
vnoremap s <nop>
vnoremap S <nop>

" override the :W! command (defined by sudo-gui.vim to be :SudoWrite!)
cabbrev W w

" lastly, load up user.vim local overrides.
" note that user.vim is not kept in the repository, and therefore
" we can use this file to load machine-specific settings
if filereadable(expand("~/.vim/user.vim"))
    source ~/.vim/user.vim
endif
" }}}

" vim: fen fdl=0 fdm=marker
