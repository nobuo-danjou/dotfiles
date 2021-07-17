syntax on
filetype on
filetype indent on
filetype plugin on

set modelines=2
set termencoding=utf-8
"set encoding=japan
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,sjis,iso-2022-jp,cp932
set fileformats=unix,dos,mac

set autoindent smartindent
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4 softtabstop=0
au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2 softtabstop=0
set expandtab

autocmd FileType perl set isfname-=-
autocmd FileType perl let &path = getcwd() . '/lib,' . &path

set showmatch

set ignorecase
set smartcase
set nohlsearch
set incsearch
set laststatus=2
set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P
function! GetStatusEx()
    let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    return str
endfunction

augroup EOL
    autocmd!
    autocmd BufWritePre * call EolSavePre()
    autocmd BufWritePost * call EolSavePost()
augroup END

function! EolSavePre()
    let b:save_bin = &bin
    if ! &eol
        let &l:bin = 1
    endif
endfunction

function! EolSavePost()
    let &l:bin = b:save_bin
endfunction

