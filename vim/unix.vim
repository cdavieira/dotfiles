vim9script

import './path.vim'

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
if empty(glob(path.vimplug_autoload_dir))
	execute '!curl -fLo ' .. path.vimplug_autoload_dir .. ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
