" ~/.vimrc
" Inspired by http://github.com/nvie/vimrc/

" -----------------------------------------------------------------------------
" Use vim settings, rather than vi settings
" This must be first, because it changes other options as a side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins
" under the ~/.vim/bundle directory
filetype off                " force reloading *after* pathogen loaded
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on   " enable detection, plugins and indenting in one step

" Change the mapleader from \ to ,
let mapleader=","

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
"set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
"set smartindent                 " use smart autoindenting when starting a new line
"set number                      " always show line numbers
set showmatch                   " show matching parenthesis
"set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase (case-sensitive otherwise)
set scrolloff=1                 " keep N lines off the edges of the screen when scrolling
set sidescrolloff=0
"set virtualedit=all             " allow the cursor to go to 'invalid' places
"set cursorline                  " highlight current line (or not)
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default

" don't show invisible characters by default, but it is enabled for some filetypes (see later)
set nolist

" strings to use in 'list' mode for the :list command
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

" when in insert mode, press <F2> to go to paste mode, where you
" can paste mass data that won't be autoindented
set pastetoggle=<F2>

" enable using the mouse if terminal emulator supports it (xterm does)
set mouse=a

" specifies what end-of-line formats will be tried when editing a new buffer
set fileformats="unix,dos,mac"

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

" }}}

" Folding rules {{{
"set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
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
"set laststatus=2                " tell VIM to always put a status line in, even if there is only one window
set showtabline=2               " show tab page labels (0 = never, 1 = when more than 1, 2 = always)
set ruler                       " show line and column number of the cursor position
" }}}

" Vim behaviour {{{

" hide buffers instead of closing them. this means that the current buffer
" can be put to background without being written; and that marks and undo
" history are preserved
set hidden

" reveal already opened files from the quickfix window instead
" of opening new buffers
set switchbuf=useopen

" remember more commands and search history
set history=1000
set undolevels=1000

" read/write a .viminfo file, don't store more than 80 lines of registers
set viminfo='20,\"80

" We typically don't want to use the current working directory as a backupdir.
" Fortunately, we can set it explicitly. See the following Vim FAQ entry:
" http://vimdoc.sourceforge.net/cgi-bin/vimfaq2html3.pl#7.2
" See also: http://news.ycombinator.com/item?id=1688068
set backupdir=~/.vim/tmp/backup//,~/tmp//,/tmp//
set directory=~/.vim/tmp/swp//,~/tmp//,/tmp//

" keep the undo history for our buffers 
if 0 && v:version >= 703
    set undofile
    set undodir=~/.vim/tmp/undo//,~/tmp//,/tmp//
endif

" make tab completion for files/buffers act like bash
set wildmenu

" show a list when pressing tab, and complete first full match
set wildmode=list:full

" ignore completion for these files
set wildignore=*.swp,*.bak,*.pyc,*.class

" change the terminal's title
set title

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

" Highlighting {{{

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

if &t_Co >= 256 || has("gui_running")
    "colorscheme molokai
    "colorscheme inkpot
    "colorscheme gardener
    "colorscheme desert256
    "colorscheme calmar256-dark
    "colorscheme calmar256-light
    "colorscheme ir_black
    "colorscheme herald
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

" Highlighting the 80th column (or relative to 'textwidth')
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
" http://vim.wikia.com/wiki/VimTip810
if 0
    if exists('+colorcolumn')
        "set colorcolumn=+0
        set colorcolumn=80
    endif
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
    match OverLength /\%81v.\+/
endif

" }}}

" Shortcut mappings {{{

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

" Use the damn hjkl keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
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

" YankRing
let g:yankring_history_dir = '$HOME/.vim/tmp'
nmap <leader>r :YRShow<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
"inoremap jj <Esc>
"inoremap jk <Esc>

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Scratch (XXX)
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

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

" NERDTree settings {{{

" Put focus on the NERD Tree with F3 (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeFind<CR>

" Store the bookmarks
let NERDTreeBookmarksFile=expand("$HOME/.vim/tmp/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
"let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
    \ '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$' ]

" }}}

" Managing buffers with LustyJuggler {{{
"map ,b :LustyJuggler<CR>
" }}}

" TagList settings {{{

nmap <leader>l :TlistClose<CR>:TlistToggle<CR>
nmap <leader>L :TlistClose<CR>

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
" exuberant ctags version in /opt/local/bin
let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}

" Gitv settings {{{

" See https://github.com/gregsexton/gitv
cabbrev git Git
cabbrev gitv Gitv
nmap <leader>gv :Gitv --all<CR>
nmap <leader>gV :Gitv! --all<CR>

" }}}

" Conflict markers {{{

" XXX: Do we even use these? See if we can get rid of this section...
if 0
    " highlight conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " shortcut to jump to next conflict marker
    nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
endif

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
        autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

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

" Skeleton processing {{{

" See also: http://stackoverflow.com/questions/162617/how-can-i-automatically-add-some-skeleton-code-when-creating-a-new-file-with-vim

if has("autocmd")

    if !exists('*LoadTemplate')
        function LoadTemplate(file)
            if a:file =~ 'furls$'
                execute "0r ~/.vim/skeleton/furls"
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

" Extra vi-compatibility {{{

" set extra vi-compatible options

" when changing a line, don't redisplay, but put a '$' at the end during the change
set cpoptions+=$

" don't start new lines w/ comment leader on pressing 'o'
set formatoptions-=o

" somehow, during vim filetype detection, this gets set for vim files,
" so explicitly unset it again
au filetype vim set formatoptions-=o

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
set wmh=0

" Adding the control keys to hjkl jump to the window and make it full screen
"nmap <C-j> <C-w>j<C-w>_
"nmap <C-k> <C-w>k<C-w>_

" Move between windows using arrow keys
"nnoremap <left>  <C-w>h
"nnoremap <right> <C-w>l
"nnoremap <up>    <C-w>k
"nnoremap <down>  <C-w>j

" Move between tabs using shifted arrow keys
"nnoremap <S-left>  gT
"nnoremap <S-right> gt

" Instead, use these arrow key mappings
nnoremap <left>     B
nnoremap <right>    E
nnoremap <up>       {
nnoremap <down>     }

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

" Disable keyword lookup in normal mode. Note that K will still work in visual mode,
" using vawK sequence, for example.
nmap K <nop>

" Program to use for keyword lookups (default is "man -s")
set keywordprg=man\ -s

" Load alternate file (swap between header and implementation).
" Can also use CTRL-^ for this.
nmap <silent> \s :A<cr>

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
function HorizontalRule()
    let @s = "-------------------------------------------------------------------------------"
    put s
endfunction
nnoremap <silent> <leader>hr :call HorizontalRule()<CR>

" Function for hiding line comments
" http://www.debian-administration.org/article/616/Hiding_comments_in_configuration_files
function HideLineComments()
    set foldmethod=expr
    set foldexpr=getline(v:lnum)=~'^\\s*//'?1:getline(prevnonblank(v:lnum))=~'^\\s*//'?1:getline(nextnonblank(v:lnum))=~'^\\s*//'?1:0
    highlight clear Folded
    highlight link Folded ignore
    normal zM
endfunction
nnoremap <silent> <leader>hc :call HideLineComments()<CR>

" Function for hiding block comments
" http://www.linuxquestions.org/questions/linux-general-1/vim-plugin-for-hiding-block-comments-466625/
function HideBlockComments()
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
source ~/.vim/user.vim
" }}}

" vim: fen fdl=0
