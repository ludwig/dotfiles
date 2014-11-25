
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
set omnifunc=syntaxcomplete#Complete

" make tab completion for files/buffers act like bash
set wildmenu

" show a list when pressing tab, and complete first full match
set wildmode=list:full

" ignore completion for these files
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o

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
set backupdir=~/.vim/tmp/backup//,~/tmp//,/tmp//
set directory=~/.vim/tmp/swp//,~/tmp//,/tmp//

" keep the undo history for our buffers (disable for now)
if 0 && exists('+undofile')
    set undofile
    set undodir=~/.vim/tmp/undo//,~/tmp//,/tmp//
endif

" update search path for opening files under cursor
" http://vim.wikia.com/wiki/Open_file_under_cursor
set path+=./include,../include

" }}}

" Layout/UI settings {{{

" don't show the intro message when starting vim
set shortmess=atI

" always show what mode we're currently editing in
set showmode

" show partial command in the last line of the screen
set showcmd

" show line and column number of the cursor position
set ruler

" show line numbers
"set number

" highlight current line, for quick orientation
set cursorline

" don't update the display while executing macros
set lazyredraw

" use a statusbar that's N rows high
set cmdheight=1

" show tab page labels (0 = never, 1 = when more than one, 2 = always)
set showtabline=1

" tell vim to always put a status line in, even if there is only one window
set laststatus=2

" don't show invisible characters by default, but it is enabled for some filetypes (see later section)
set nolist

" strings to use in 'list' mode for the :list command
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
"set listchars+=eol:¬

" syntax coloring lines that are too long slows down the world, so set a cap
set synmaxcol=2048

" disable gui toolbar in gvim
if has('gui_running')
    set guioptions-=T
endif

" select a default colorscheme
if &t_Co >= 256 || has('gui_running')
    " other colorschemes:
    "   default, molokai, badwolf, jellybeans, herald, inkpot,
    "   tir_black, gardener, desert256, calmar256-dark, calmar256-light,
    "   Tomorrow, Tomorrow-Night, Tomorrow-Night-Bright,
    "   Tomorrow-Night-Eighties
    colorscheme default
endif

" switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has('gui_running')
    syntax on
endif

" Highlight the current line (use \c to toggle 'cursorline')
" http://vim.wikia.com/wiki/Highlight_current_line
"highlight CursorLine term=standout cterm=standout
highlight CursorLine term=standout cterm=NONE ctermbg=222 guibg=#F1F5FA
nnoremap <silent> \c :set cursorline!<CR>

" Display line numbers (toggle with \a)
" http://vim.wikia.com/wiki/Display_line_numbers
nmap <silent> \a :set number!<CR>
nmap <silent> ,a :set number!<CR>
set numberwidth=5               " change width of gutter column
set cpoptions+=n                " use the number column for wrapped lines
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

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

" disable the substitute commands (actually, I need these for vim-sneak)
"nnoremap s <nop>
"nnoremap S <nop>
"vnoremap s <nop>
"vnoremap S <nop>

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

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" }}}

" My new commands {{{
"   Man Page Lookup {{{

" Disable keyword lookup in normal mode. Note that K will still work in visual mode,
" using vawK sequence, for example.
nmap K <nop>

" Program to use for keyword lookups (default is "man -s")
set keywordprg=man\ -s

" Open man page for word under cursor (use '<cword>' to retrieve current word under cursor)
" http://vim.wikia.com/wiki/Open_a_window_with_the_man_page_for_the_word_under_the_cursor
" http://vimdoc.sourceforge.net/htmldoc/windows.html#special-buffers
function! _ReadMan(man_sec, man_word, winpos)
    " If 'man_sec' is 0, use empty string instead...
    " we perform this check because v:count is 0 by default
    let s:man_sec = a:man_sec
    if s:man_sec == 0
        let s:man_sec = ''
    endif
    " Open a new window
    exe ":wincmd n"
    exe ":wincmd " . a:winpos
    " Make it a scratch buffer
    exe ":setlocal buftype=nofile"
    exe ":setlocal bufhidden=hide"
    exe ":setlocal noswapfile"
    " Don't list buffer either
    exe ":setlocal nobuflisted"
    " Read in the man page for 'man_word' (col -b is for formatting)
    exe ":r!man " . s:man_sec . " " . a:man_word . " | col -b"
    exe ":set ft=man"
    " Go to first line and delete it
    exe ":goto"
    exe ":delete"
endfunction

" Open up 'man <sec> <word>' in same window
function! ReadManS(sec,word)
    call _ReadMan(a:sec, a:word, 'o')
endfunction

" Open up 'man <word>' in same window
function! ReadMan(word)
    call _ReadMan('', a:word, 'o')
endfunction

" Map a key to the ReadMan() function
map ,K  :<C-U>call _ReadMan(v:count, expand('<cword>'), 'o')<CR>
map ,ko :<C-U>call _ReadMan(v:count, expand('<cword>'), 'o')<CR>
map ,kk :<C-U>call _ReadMan(v:count, expand('<cword>'), 'K')<CR>
map ,kl :<C-U>call _ReadMan(v:count, expand('<cword>'), 'L')<CR>
map ,kh :<C-U>call _ReadMan(v:count, expand('<cword>'), 'H')<CR>
map ,kj :<C-U>call _ReadMan(v:count, expand('<cword>'), 'J')<CR>

command! -nargs=+ Man call ReadMan(<f-args>)
command! -nargs=+ ManS call ReadManS(<f-args>)

cabbrev man Man
cabbrev mans ManS

"   }}}
"   Hide Comments {{{

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

"   }}}
"   HorizontalRule() {{{

" Horizontal rule separator (80 characters wide)
function! HorizontalRule()
    let @s = "-------------------------------------------------------------------------------"
    put s
endfunction
nnoremap <silent> <leader>hr :call HorizontalRule()<CR>

"   }}}
"   GrepQFix() {{{

" Grep current word under cursor, and list occurrences in quickfix window
" http://vim.wikia.com/wiki/Search_using_quickfix_to_list_occurrences
function! GrepQFix(pat)
    exe ':vimgrep ' . a:pat . ' ' . expand('%')
    exe ':match Search /' . a:pat . '/'
    copen
    "cc
endfunction
command! -nargs=1 GREP :call GrepQFix(<f-args>)
nnoremap ,g :call GrepQFix(expand('<cword>'))<CR>
nnoremap ,G :GREP·

"   }}}
"   GoogleSearch() {{{

" Google current word
" http://www.vim.org/scripts/script.php?script_id=3551
function! GoogleSearch(...)
    let q = substitute(join(a:000, " "), ' ', "+", "g")
    "exe '!launch -l https://encrypted.google.com/search?q=' . q
    exe '!launch -l ''https://www.google.com/search?btnI=1&q=' . q . ''''
endfunction
command! -nargs=+ Google call GoogleSearch(<f-args>)
nnoremap \g :Google <cword><CR><CR>
nnoremap \G :Google·

"   }}}
"   QFix() {{{

" Tame the quickfix window (open/close using ,f) -- try ,q instead
"nmap <silent> <leader>f :QFix<CR>
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

"   }}}
" }}}

" Load filetype specific settings {{{

" only do this part when compiled with support for autocommands
if has ('autocmd')
    augroup omnifunc "{{{
        autocmd filetype css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd filetype html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd filetype python setlocal omnifunc=pythoncomplete#Complete
        autocmd filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup end " }}}
    augroup invisible_chars "{{{
        " Clear the group with 'autocmd!'
        au!
        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}
    augroup css_files "{{{
        au!
        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}
    augroup rst_files "{{{
        au!
        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        "autocmd filetype rst match ErrorMsg '\%>73v.\+'
    augroup end "}}}
    augroup ruby_files "{{{
        au!
        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end "}}}
endif

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

" Move between tabs using shifted arrow keys
"nnoremap <S-left> gT
"nnoremap <S-right> gt

" tabnew shortcuts
" http://www.reddit.com/r/vimcommands/comments/kbheh/tabnew/
"nmap ,, :tabnew<CR>
"nmap ,. :tabnext<CR>
"nmap ., :tabprev<CR>

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

" Temporary fix for syntax issue with sass files (missing groups?)
" https://github.com/ChrisYip/Better-CSS-Syntax-for-Vim/issues/9
"au BufRead,BufNewFile *.scss set filetype=css

" }}}

" vim: fen fdl=0 fdm=marker
