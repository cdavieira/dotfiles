source $VIMRUNTIME/defaults.vim
version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap Q gq
xmap Q gq
omap Q gq
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set display=truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=en
set history=200
set hlsearch
set incsearch
set langnoremap
set nolangremap
set nrformats=bin,hex
set ruler
set scrolloff=5
set showcmd
set ttimeout
set ttimeoutlen=100
set viminfo='20,\"50
set wildmenu
set backupdir=~/.cache/vim/backup//
set undodir=~/.cache/vim/undo//
set directory=~/.cache/vim/swap//
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set wildmenu
set number
set shiftwidth=4
set tabstop=4
" vim: set ft=vim :
