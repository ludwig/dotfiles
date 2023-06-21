" Use vim settings, rather than vi settings
set nocompatible

" Basic settings {{{

" expand tabs by default (overloadable per filetype later)
set expandtab

" a tab is four spaces
set tabstop=4

" when hitting <BS>, pretend like a tab is removed, even if spaces
set softtabstop=4

" number of spaces to use for autoindenting
set shiftwidth=4

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab

" always set autoindenting on
set autoindent

" copy the previous indentation on autoindenting
set copyindent

" use smart autoindenting when starting a new line
"set smartindent

" show matching parentheses
set showmatch

" ignore case when searching
"set ignorecase

" ignore case if search pattern is all lowercase (case-sensitive otherwise)
set smartcase

" search/replace 'globally' (on a line) by default
set gdefault

" highlight search terms
set hlsearch

" show search matches as you type
set incsearch

" keep N lines off the edges of the screen when scrolling
set scrolloff=1

" like scrolloff, but for horizontal scrolling
set sidescrolloff=1

" allow the cursor to go to 'invalid' places
"set virtualedit=all

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" remember more commands and search history
set history=1000
set undolevels=1000

" modeline settings (although one should disable modeline by default, as a security measure)
set modelines=5
set modeline

" don't reset cursor to start of line when moving around
set nostartofline

" when on, splitting a window will put the new window to the right of the current one
set nosplitright

" when on, splitting a window will put the new window below the current one
set nosplitbelow

" hide buffers instead of closing them. this means that the current buffer can
" be put to background without being written; and that marks and undo history
" are preserved
set hidden

" reveal already opened files from the quickfix window, instead of opening 
" new buffers
set switchbuf=useopen

" don't wrap lines
"set nowrap

" set this mode when editing binary files (note: expandtab is turned off in this mode!)
"set binary

" set this mode when pasting text
"set paste

" when in insert mode, press <F2> to go to paste mode, where you can
" paste mass data that won't be autoindented
set pastetoggle=<F2>

" turn on omnicompletion
" http://vim.wikia.com/wiki/Omni_completion
" TODO: set this up again
"set omnifunc=syntaxcomplete#Complete

" make tab completion for files/buffers act like bash
set wildmenu

" show a list when pressing tab, and complete first full match
set wildmode=list:full

" ignore completion for these files
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o

" Set up vim to use the system clipboard
set clipboard=unnamed

" }}}

" Terminal/file settings {{{

" character encoding used inside vim
set encoding=utf-8

" character encoding used for the terminal
set termencoding=utf-8

" change the terminal's title
set title

" always use a fast terminal (disable if slow)
set ttyfast

" don't beep terminal
set noerrorbells
set visualbell

" enable the use of a mouse, if terminal emulator supports it (xterm does)
set mouse=a

" don't add empty newlines at the end of files
set noeol

" specifies what end-of-line formats will be tried when editing a new buffer
set fileformats="unix,dos,mac"

" read/write a .viminfo file, don't store more than 80 lines of registers
set viminfo='20,\"80

" We typically don't want to use current working directory as a backupdir.
" Fortunately, we can set it explicitly. See the following Vim FAQ entry:
" http://vimdoc.sourceforge.net/cgi-bin/vimfaq2html3.pl#7.2
" The double tailing slash will store files using full paths (so you can edit
" identically named files with no problems).
" See also: http://news.ycombinator.com/item?id=1688068

set nobackup
set writebackup
set backupdir=~/.vim/tmp/backup//,~/tmp//,/tmp//
if !isdirectory(expand('~/.vim/tmp/backup'))
    call mkdir(expand('~/.vim/tmp/backup'), 'p')
endif

set swapfile
set directory=~/.vim/tmp/swp//,~/tmp//,/tmp//
if !isdirectory(expand('~/.vim/tmp/swp'))
    call mkdir(expand('~/.vim/tmp/swp'), 'p')
endif

" keep the undo history for our buffers (disable for now)
if 0 && exists('+undofile')
    set undofile
    set undodir=~/.vim/tmp/undo//,~/tmp//,/tmp//
endif

" update search path for opening files under cursor
" http://vim.wikia.com/wiki/Open_file_under_cursor
set path+=./include,../include

" }}}

" Fold settings {{{

" enable folding
"set foldenable

" add a fold column
"set foldcolumn=2

" by default, detect triple-{ style fold markers
set foldmethod=marker

" by default, start out with everything folded
set foldlevelstart=0

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

" Misc settings {{{

" Don't let cindent muck with ':' in insert-mode
set cinkeys-=:

" when changing a line, don't redisplay, but put a '$' at the end during the change
set cpoptions+=$

" don't start new lines w/ comment leader on pressing 'o'
set formatoptions-=o

" somehow, during vim filetype detection, this gets set for vim files, so
" explicitly unset it again
au filetype vim set formatoptions-=o

" Program to use for formatting text
" Install with 'brew install par'
" 'gqip' formats paragraph using external tool specified in 'formatprg'
" 'gwip' formats paragraph using vim's internal formatting tool
" see 'par help' at the command line for available options
" http://vimcasts.org/episodes/formatting-text-with-par/
set formatprg=par
"set formatprg=par\ w50
"set formatprg=par\ w50req
"set formatprg=par\ w72p3qrf

" to enable automatic text wrapping use these settings (leave these lines commented out)
"set textwidth=80
"set formatoptions+=t

" restore cursor position upon reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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

" Use CTRL-C as ESC
map <C-c> <Esc>

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Quickly close the current window
"nnoremap <leader>q :q<CR>

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

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

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

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Clear the signcolumn
" https://superuser.com/questions/713285/how-to-remove-sign-column-after-doing-grep-in-vim
nmap <silent> <leader>u :sign unplace *<CR>

" }}}

" My new commands {{{
"   HorizontalRule() {{{

" Horizontal rule separator (80 characters wide)
function! HorizontalRule()
    let @s = "-------------------------------------------------------------------------------"
    put s
endfunction
nnoremap <silent> <leader>hr :call HorizontalRule()<CR>

"   }}}
" }}}

" Suggestions from Reddit and HN {{{

" Merge most of these suggestions into the sections above (whenever possible).
" Also, make sure to include a link to the source of each suggestion.
"   http://www.reddit.com/r/vim/comments/e341j/time_for_a_vim_tricks_thread_please_search_before/

" reselect visual block after changing its indent
vnoremap < <gv
vnoremap > >gv

" Window mappings
set winminheight=0

" What is the syntax name for the thing under my cursor?
" Useful for debugging syntax highlighting
" To use, type ":echo SyntaxItem()" at the cursor location
function! SyntaxItem()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" }}}

" Extra user settings to load last {{{

" override the :W! command (defined by sudo-gui.vim to be :SudoWrite!)
cabbrev W w

" }}}

" vim: fen fdl=0 fdm=marker
