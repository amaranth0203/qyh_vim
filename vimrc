let $LANG='zh_CN.UTF-8'

" [+] bundle start
set nocompatible              " be iMproved, required
filetype off                  " required
if has( "win32" ) || has( "win16" )
    set rtp+=$USERPROFILE/.qyh_vim/bundle/Vundle.vim
    call vundle#begin('$USERPROFILE/.qyh_vim/bundle')
else
    set rtp+=~/.qyh_vim/bundle/Vundle.vim
    call vundle#begin('~/.qyh_vim/bundle')
endif
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'severin-lemaignan/vim-minimap'
call vundle#end()            " required
filetype plugin indent on    " required
" [+] bundle end

au BufWritePre * :set binary | set noeol
au BufWritePost * :set nobinary | set eol
au VimLeave * call SaveSess( )
"au VimEnter * :PluginInstall
"au VimEnter * call Switch_to_leftest_buffer( )

syntax on
colo desert
set encoding=utf-8
set guifont=Consolas:h12:cANSI
set linespace=0
set guioptions-=m
set guioptions-=T
set nocompatible
set expandtab
set backspace=indent,eol,start
set number
set shiftwidth=4
set tabstop=4
set autochdir
set ruler
set nobackup
set nowritebackup
set noswapfile
set showcmd
set title
set hlsearch
set incsearch
set nowrap

map! <s-tab> <BS><BS><BS><BS>
nnoremap <expr>j Qyh_j( ) 
nnoremap k k
nnoremap <c-\> :set nohlsearch<cr>
nnoremap * *<S-n>zz
nnoremap % %zz
nmap <F7> :call AutoLoadCTagsAndCScope()<CR>
nmap <C-w><C-w> :call CloseBufWithNERDTree( )<cr>
nmap <C-w>1  :call Win_prop( 1 )<cr>
nmap <C-w>`1 :call Win_prop( -1 )<cr>
nmap <C-w>2  :call Win_prop( 2 )<cr>
nmap <C-w>`2 :call Win_prop( -2 )<cr>
nmap <C-w>3  :call Win_prop( 3 )<cr>
nmap <C-w>`3 :call Win_prop( -3 )<cr>
imap <C-cr> <C-c><S-o>
if has( "win32" ) || has( "win16" )
    nnoremap <A-j> j
    nnoremap <A-k> k
    nnoremap <A-\> :set hls<cr>
    nmap <A-h> :bp<cr>
    nmap <A-l> :bn<cr>
    map! <A-q> <C-c>
    vmap <A-q> <C-c>
    vmap <A-f> y:set nomagic<cr>/<C-R>"<cr>:set magic<cr><S-n>zz
    imap <A-s> <esc>:w<cr>
    nmap <A-s> :w<cr>
    set termencoding=gbk
else
    nnoremap <esc>j j
    nnoremap <esc>k k
    nnoremap <esc>\ :set hls<cr>
    nmap <esc>h :bp<cr>
    nmap <esc>l :bn<cr>
    map! <esc>q <C-c>
    vmap <esc>q <C-c>
    vmap <esc>f y:set nomagic<cr>/<C-R>"<cr>:set magic<cr><S-n>zz
    imap <esc>s <esc>:w<cr>
    nmap <esc>s :w<cr>
    set termencoding=utf-8
endif

fu! Switch_to_leftest_buffer( )
    execute 'e qyh.tmp.qyh.tmp'
    execute 'bn'
    execute 'bd qyh.tmp.qyh.tmp'
endfunction

fu! CloseBufWithNERDTree( )
    if exists( "t:NERDTreeBufName" )
        if bufwinnr( t:NERDTreeBufName ) != -1
            execute "NERDTreeToggle"
            execute "bd"
            execute "NERDTreeToggle"
            execute "wincmd w"
            return 
        endif
    endif
    execute "bd"
endfunction

fu! SaveSess( )
    execute 'NERDTreeClose'
    if has( "gui_running" )
        execute 'mksession! ~/qyh_session_gvim.vim'
    else
        execute 'mksession! ~/qyh_session_vim.vim'
    endif
endfunction

fu! Win_prop( param )
    if a:param == 1
        execute 'call libcallnr("vimtweak.dll", "SetAlpha", 200)'
    elseif a:param == -1
        execute 'call libcallnr("vimtweak.dll", "SetAlpha", 255)'
    elseif a:param == 2
        execute 'call libcallnr("vimtweak.dll", "EnableMaximize", 1)'
    elseif a:param == -2
        execute 'call libcallnr("vimtweak.dll", "EnableMaximize", 0)'
    elseif a:param == 3
        execute 'call libcallnr("vimtweak.dll", "EnableTopMost", 1)'
    elseif a:param == -3
        execute 'call libcallnr("vimtweak.dll", "EnableTopMost", 0)'
    endif
endfunction

fu! Qyh_j( )
    if line( '.' ) > winheight( 0 ) / 2
        return "j"
    else
        return "j"
endfunction

fu! AutoLoadCTagsAndCScope()
    let max = 10
    let dir = getcwd( ).'/'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'GTAGS')
            execute 'cs add ' . dir . 'GTAGS ' . glob("`pwd`")
            let break = 1
        endif
        if filereadable(dir . 'cscope.out')
            execute 'cs add ' . dir . 'cscope.out ' . strpart( dir , 0 , strlen( dir ) - 1 ) 
            "echom 'cs add ' . dir . 'cscope.out ' . strpart( dir , 0 , strlen( dir ) - 1 ) 
            let break = 1
        endif
        if filereadable(dir . 'tags')
            execute 'set tags =' . dir . 'tags'
            "echom dir.'tags'
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf

" for Cscope
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" for TList
nmap <leader>tl :TlistToggle<cr>

" for NERDTree
nmap <leader>ne :NERDTree<cr>
nmap <leader>net :NERDTreeToggle<cr>
nmap <leader>nec :ClearBookmarks 
nmap <leader>neb :Bookmark 

" for NERD Commenter
filetype plugin on
let NERDSpaceDelims=1

" for airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '-'
let g:airline#extensions#tabline#right_sep = '-'
set laststatus=2

" set default 'runtimepath' (without ~/.vim folders)
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)
" what is the name of the directory containing this file?
let s:portable = expand('<sfile>:p:h')
" add the directory to 'runtimepath'
let &runtimepath = printf('%s,%s,%s/after,~/.qyh_vim/bundle/Vundle.vim', s:portable, &runtimepath, s:portable)