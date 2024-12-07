vim9script

# these variables are assigned either by 'UnixSpecifics' or 'WindowsSpecifics'.
# once set, these will be used by 'SetOSAgnosticOptions'.
var vim_config_dir: string
var vim_cache_dir: string
var vimplug_autoload_dir: string
export var vimplug_dir: string


export def Setup(): void
	if has('win64')
		LoadWindowsSpecifics()
	else
		LoadUnixSpecifics()
	endif
	SetOSAgnosticOptions()
enddef



def SetOSAgnosticOptions(): void
	# create additional folders used to store '~', ''.un' and '.swp' files
	for folder in ['backup', 'swap', 'undo']
		var folderpath = vim_cache_dir .. folder
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
enddef



def LoadUnixSpecifics(): void
	vim_config_dir = '~/.config/vim/'
	vim_cache_dir = '~/.cache/vim/'
	vimplug_autoload_dir = vim_config_dir .. 'autoload/plug.vim'
	vimplug_dir = vim_config_dir .. 'vim-plug'

	# folder to store '~' files
	set backupdir=~/.cache/vim/backup/

	# folder to store '.swp' files
	set directory=~/.cache/vim/swap/

	# folder to store '.un' files
	set undodir=~/.cache/vim/undo/

	# folder to store 'viminfo' (save session information upon quitting)
	set viminfofile=~/.cache/vim/viminfo

	# choose the desired command to use in conjunction with 'K'
	set keywordprg=:Man

	# user shell
	# set shell=/usr/bin/fish
	set shell=/bin/bash
	set shellcmdflag=-c

	# in case vim plug isn't already installed, install it (https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation)
	if empty(glob(vimplug_autoload_dir))
		execute '!curl -fLo ' .. vimplug_autoload_dir .. ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
enddef



def LoadWindowsSpecifics(): void
	# run this in an elevated shell:
	# New-Item -ItemType SymbolicLink -Target C:\Users\cd_vi\dotfiles\vim\win_vimrc -Path C:\Users\cd_vi\vimfiles\vimrc
	# read ':help gui_w32.txt' for more information about using vim in windows

	vim_config_dir = $USERPROFILE .. '\vimfiles\'
	vim_cache_dir = vim_config_dir .. 'cache\'
	vimplug_autoload_dir = vim_config_dir .. 'autoload\plug.vim'
	vimplug_dir = vim_config_dir .. 'vim-plug'

	# folder to store '~' files
	set backupdir=$USERPROFILE\vimfiles\cache\backup

	# folder to store '.swp' files
	set directory=$USERPROFILE\vimfiles\cache\swap

	# folder to store '.un' files
	set undodir=$USERPROFILE\vimfiles\cache\undo

	# folder to store 'viminfo' (save session information upon quitting)
	set viminfofile=$USERPROFILE\vimfiles\viminfo

	# choose the desired command to use in conjunction with 'K'
	set keywordprg=:help

	# user shell
	set shell=pwsh
	set shellcmdflag=-Command

	# in case vim plug isn't already installed, install it (https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation)
	if empty(glob(vimplug_autoload_dir))
		silent echo system('iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni ' .. vimplug_autoload_dir .. ' -Force')
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
enddef
