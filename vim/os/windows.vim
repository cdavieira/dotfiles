vim9script

import '../utils/path.vim'

# run this in an elevated shell:
# New-Item -ItemType SymbolicLink -Target C:\Users\cd_vi\dotfiles\vim\win_vimrc -Path C:\Users\cd_vi\vimfiles\vimrc
# read ':help gui_w32.txt' for more information about using vim in windows

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
if empty(glob(path.vimplug_autoload_dir))
	silent echo system('iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni ' .. path.vimplug_autoload_dir .. ' -Force')
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
