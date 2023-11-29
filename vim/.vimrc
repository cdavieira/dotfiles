" INTERNAL STUFF
source $VIMRUNTIME/defaults.vim
version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save




" VARIABLES
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/swap//
set display=truncate
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=200
set hlsearch
set incsearch
set langnoremap
set nolangremap
set nrformats=bin,hex
set relativenumber
set ruler
set scrolloff=5
set shiftwidth=2
set showcmd
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set tabstop=2
set ttimeout
set ttimeoutlen=100
set undodir=~/.cache/vim/undo//
set viminfo='20,\"50
set wildmenu




""" VIM PLUG
call plug#begin('~/.vim/vim-plug')
" linter and lsp
" Plug 'dense-analysis/ale'

" filesystem explorer
Plug 'preservim/nerdtree'

" icons for nerdtree and other plugins
Plug 'ryanoasis/vim-devicons'

" vim + rust = ♥
Plug 'rust-lang/rust.vim'

" write ', ", <> simultaneosly at the beginning and at the end of a sentence, word, line
Plug 'tpope/vim-surround'

" automatically write 'end' for lua and other programming languages
Plug 'tpope/vim-endwise'

" better start menu
Plug 'mhinz/vim-startify'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" easy comments
Plug 'preservim/nerdcommenter'
" Plug 'tpope/vim-commentary'

" git integration
Plug 'tpope/vim-fugitive'

call plug#end()




""" MAPPINGS
nmap Q gq
xmap Q gq
omap Q gq
nnoremap <Space>e <Cmd>NERDTreeToggle<CR>




" startify variables

let g:startify_bookmarks = [
	\ {'vimrc': '~/.vimrc'},
	\ {'fish': '~/dotfiles/fish/config.fish'},
	\ {'kitty': '~/dotfiles/kitty/kitty.conf'},
	\ ]

let g:startify_commands = [
	\ ':help',
	\ {'h startify': 'help startify'},
	\ ]



" vim: set ft=vim :
