vim9script

# enable filetype recognition, plugins for filetypes and indent files
filetype plugin indent on

# load package 'editorconfig' (shipped with vim)
packadd editorconfig

# turn on syntax highlighting for different filetypes
syntax on

# folder to store '~' files
# if !empty($MYVIM_BACKUP_DIR)
#   set backup
#   set backupdir=$MYVIM_BACKUP_DIR
# else
#   set nobackup
# endif

# folder to store '.swp' files
if !empty($MYVIM_SWAP_DIR)
  set swapfile
  set directory=$MYVIM_SWAP_DIR
else
  set noswapfile
endif

# folder to store '.un' files
# if !empty($MYVIM_UNDO_DIR)
#   set undofile
#   set undodir=$MYVIM_UNDO_DIR
# else
#   set noundofile
# endif

if !empty($MYVIM_VIMINFO)
  # viminfo configuration
  # \" ('"' escaped): max. number of lines saved for each register
  # ': max. number of previously edited files for which the marks are remembered
  set viminfo='20,\"50

  # folder to store 'viminfo' (save session information upon quitting)
  set viminfofile=$MYVIM_VIMINFO
else
  set viminfofile="NONE"
endif

# set character encoding used inside vim
set encoding=UTF-8

# list of character encodings to consider when editing existing files
set fileencodings=utf-8,default

# disable text wrapping when text doesn't fit in the window width
set nowrap

# .editorconfig fallbacks
# NOTE: you can always insert actual <Tab> characters in insert mode with 'Ctrl-V+<Tab>'
# The number of spaces that an actual <Tab> in the file visually represents.
set tabstop=8
# The actual number of spaces that a <Tab> inserts in insert mode. Whenever
# the number of spaces inserted by 'softtabstop' is equal to the value of
# 'tabstop', an actual <Tab> is inserted instead of spaces.
set softtabstop=2
# The number of spaces to use for each step of (auto)indent. Used for 'cindent',
# >>, <<, etc.
set shiftwidth=8
# Do not replace tabs with spaces
set noexpandtab

# Maximum width of text that is being inserted. A longer line will be broken
# after white space to get this width
set textwidth=78

# minimal number of columns to use for the line number
set numberwidth=3

# allows automatically erasing all whitespaces associated with autoindents,
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

# Write the contents of the file, if it has been modified, on each `:next`,
# `:rewind`, `:last`, `:first`, `:previous`, `:stop`, `:suspend`, `:tag`,
# `:!`, `:make`, CTRL-] and CTRL-^ command; and when a `:buffer`, CTRL-O,
# CTRL-I, '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
set autowrite

# Like 'autowrite', but also used for commands ":edit", ":enew", ":quit",
# ":qall", ":exit", ":xit", ":recover" and closing the Vim window.
set autowriteall

# timeout and ttimeout on
# toss invoking unfinished commands related to mappings and keycodes
set timeout
set ttimeout

# because timeout and ttimeout are on, set a timeout value for mappings in ms
# set timeoutlen=3000

# because timeout and ttimeout are on, set a different timeout value for keycodes in ms
set ttimeoutlen=100

# enhance commandline completion, by enabling 'wildchar' to invoke
# completion
# read: ':h set ins-completion-menu'
set wildmenu

# read ":help 'verbose'" for more on this. This might be useful to debug the internals of vim.
# set verbose=12
# set verbosefile=~/.config/vim/verbose

# Each item has a pattern that is matched against the 'term' option, a colon
# and the protocol name to be used.
set keyprotocol=kitty:kitty,foot:kitty,ghostty:kitty,wezterm:kitty

# the following makes kitty complain about vim using xterm’s
# 'modifyOtherKeys', therefore it was removed
# read: https://sw.kovidgoyal.net/kitty/keyboard-protocol/
# set keyprotocol+=xterm:mok2

# remove beeps
set visualbell t_vb=

# changes the way cmdline-completion is done
# Display the completion matches using the popup menu in the same style as the
# |ins-completion-menu|
g:wildoptions = "pum"

# use <Space> as the map leader
g:mapleader = " "

# use ',' as the local leader
g:maplocalleader = ","

# open manpages in a new tab
g:ft_man_open_mode = 'tab'



### Programming languages

## C
# read:
# ':h C-indenting'
# ':h cinoptions'
# ':h cinoptions-values'
# ':h cindent'
# ':h smartindent'
# inserts 4 times the value for 'shiftwidth' when indenting
set cinoptions=4s

# read:
# ':h o'
# ':h formatoptions'
