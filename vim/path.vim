vim9script

export var vim_config_dir: string
export var vim_cache_dir: string
export var vimplug_autoload_dir: string
export var vimplug_dir: string

if has('win64')
	vim_config_dir = $USERPROFILE .. '\vimfiles\'
	vim_cache_dir = vim_config_dir .. 'cache\'
	vimplug_autoload_dir = vim_config_dir .. 'autoload\plug.vim'
	vimplug_dir = vim_config_dir .. 'vim-plug'
else
	vim_config_dir = '~/.config/vim/'
	vim_cache_dir = '~/.cache/vim/'
	vimplug_autoload_dir = vim_config_dir .. 'autoload/plug.vim'
	vimplug_dir = vim_config_dir .. 'vim-plug'
endif
