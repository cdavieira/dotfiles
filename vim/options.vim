vim9script

import './path.vim'

# operating system independent options

# create additional folders used to store '~', ''.un' and '.swp' files
for folder in ['backup', 'swap', 'undo']
	var folderpath = path.vim_cache_dir .. folder
	if empty(glob(folderpath))
		mkdir(folderpath, 'p')
	endif
endfor

# disable loading plugins from folders intended for windows
set rtp-=$VIM/vimfiles
set rtp-=$VIM/vimfiles/after
set packpath-=$VIM/vimfiles
set packpath-=$VIM/vimfiles/after

# load filetype plugin 'man.vim' (shipped with vim)
runtime ftplugin/man.vim

# enable filetype recognition, plugins for filetypes and indent files
filetype plugin indent on

# load package 'editorconfig' (shipped with vim)
packadd editorconfig

# turn on syntax highlighting for different filetypes
syntax on

# 'background' and 'colorscheme' operate together to set vim's visuals
set background=dark
# slate, retrobox, wildcharm, evening, desert, habamax, sorbet
colorscheme retrobox

# viminfo configuration
# \" ('"' escaped): max. number of lines saved for each register
# ': max. number of previously edited files for which the marks are remembered
set viminfo='20,\"50

# set character encoding used inside vim
set encoding=UTF-8

# list of character encodings to consider when editing existing files
set fileencodings=utf-8,default

# disable text wrapping when text doesn't fit in the window width
set nowrap

# .editorconfig fallbacks
set shiftwidth=2
set tabstop=2
set textwidth=78
set numberwidth=2

# allow automatically erasing all whitespaces associated with autoindents,
# line breaks and the start of insert when pressing 'Ctrl-W'/'Ctrl-U'
set backspace=indent,eol,start

# show line numbers relative to the current one
set relativenumber

# jump to matching patterns while typing after pressing '/', '?' in normal mode
set incsearch

# show the line and column number of the cursor position
set ruler

# show unfinished commands in the bottom right
set showcmd

# set english/german as the default languages for help files
# german is not implemented yet for vim
set helplang=en,de

# automatically read buffers that were modified outside vim (by other text editors)
set autoread

# timeout and ttimeout on
# toss invoking unfinished commands related to mappings and keycodes
set timeout
set ttimeout

# because timeout and ttimeout are on, set a timeout value for mappings in ms
# set timeoutlen=3000

# because timeout and ttimeout are on, set a different timeout value for keycodes in ms
set ttimeoutlen=100

# enhance commandline completion operation, by enabling 'wildchar' to invoke
# completion
set wildmenu
