
" Cscope is a developer's tool for browsing source code.
"
"   http://cscope.sourceforge.net/
"   http://cscope.sourceforge.net/cscope_vim_tutorial.html
"   http://cscope.sourceforge.net/cscope_maps.vim
"
"   http://vim.wikia.com/wiki/Cscope
"   http://vim.wikia.com/wiki/Autoloading_Cscope_Database
" 

" XXX: try removing cscope_maps.vim ??


" http://vim.wikia.com/wiki/Cscope
if 0 && has('cscope')

    "set cscopetag
    set nocscopetag

    set cscopeverbose
    "set nocscopeverbose

    set cscopetagorder=1
    "set cscopetagorder=0

    "set cscopequickfix=""
    set cscopequickfix=s+,c+,d+,i+,t+,e+

    "if has('quickfix')
    "    set cscopequickfix=s+,c+,d+,i+,t+,e+
    "endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    " define a command for loading cscope db for vim source code
    "let $VIMSRC = expand('~/dev/vim')
    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src

    " http://vim.wikia.com/wiki/Autoloading_Cscope_Database
    function! LoadCscope()
        let db = findfile("cscope.out", ".;")
        if (!empty(db))
            let path = strpart(db, 0, match(db, "/cscope.out$"))
            "set nocscopeverbose     " suppress 'duplicate connection' error
            exe "cs add " . db . " " . path
            "set cscopeverbose
        endif
    endfunction
    "au BufEnter /* call LoadCscope()

endif

