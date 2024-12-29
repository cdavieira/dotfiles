vim9script

type Dirpath = string

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


export def SetNERDVariables()
	# disallow NERDTree extension from creating unwanted mappings
	g:NERDCreateDefaultMappings = 0
enddef

export def SetVimLSPVariables()
	### vimlsp
	# abort `:LspDocumentFormatSync` or `:LspDocumentRangeFormatSync` after 1000ms
	# g:lsp_format_sync_timeout = 1000

	# disable calling a custom function when over some text while the preview is still open
	# g:lsp_preview_doubletap = 0

	# automatically close floating previews upon cursor movement
	# g:lsp_preview_autoclose = 0

	# enable support for diagnostics like warnings and error messages
	g:lsp_diagnostics_enabled = 1

	# enable signs like W> and E> for diagnostics messages
	g:lsp_diagnostics_signs_enabled = 0

	# enables showing the error message in the command mode bar
	# NOTE: i heavily depend on this
	g:lsp_diagnostics_echo_cursor = 1

	# set how much time (in ms) the error message should stay up in the commandbar
	g:lsp_diagnostics_echo_delay = 500

	# enables a floating window of diagnostic error for the current line to
	# status. Requires lsp_diagnostics_enabled = 1.
	# NOTE: This is the useful floating error message that i heavily depend on
	# g:lsp_diagnostics_float_cursor = 1

	# set how much time (in ms) the floating error message should take before
	# opening the floating window
	# g:lsp_diagnostics_float_delay = 200

	# keep cursor focus on the document rather than on the preview-window when it
	# pops up (ex: when hovering)
	# NOTE: the preview-window can be closed using the default mapping for that: <c-w><c-z>
	# g:lsp_preview_keep_focus = 1

	# Enables virtual text to be shown next to diagnostic errors.
	g:lsp_diagnostics_virtual_text_enabled = 0

	# whether virtual text should be on during insertion mode
	g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0

	# Determines the align of the diagnostics virtual text
	# g:lsp_diagnostics_virtual_text_align = "above"

	# Determines whether or not to wrap the diagnostics virtual text.
	# g:lsp_diagnostics_virtual_text_wrap = "truncate"

	# A |List| containing one element of type |Funcref|.
	# g:lsp_get_supported_capabilities = [function('lsp#default_get_supported_capabilities')]
	# Note: You can obtain the default supported capabilities of vim-lsp by
	# calling `lsp#default_get_supported_capabilities` from within your function.

	# g:lsp_snippet_expand = []

	# [experimental] enables workspace capabilities when the lsp supports it by
	# calling the function 'root_uri'.
	# read ':h vim-lsp-workspace-folders' for details
	# g:lsp_experimental_workspace_folders = 1

	# create a log file to inspect lsp action
	# g:lsp_log_file = expand(path.vim_config_dir .. 'vim-lsp.log')


	### Asyncomplete
	# create a log file to inspect async action
	# g:asyncomplete_log_file = expand(path.vim_config_dir .. 'asyncomplete.log')
enddef

def SetALEVariables()
	g:ale_fixers = {
		'*': ['remove_trailing_lines', 'trim_whitespace'],
		'javascript': ['eslint'],
	}
enddef

export def LoadVimPlug(vimplug_dir: Dirpath)
	g:plug#begin(vimplug_dir)

	# If one day i start feeling too lazy with configuring vim myself,
	# i will just use the following plugin:
	# https://github.com/wolandark/wim



	###############
	#### THEMES ###
	###############
	# https://github.com/morhetz/gruvbox
	# legacy Plug 'morhetz/gruvbox'

	# https://draculatheme.com/vim
	# https://github.com/dracula/dracula-theme
	legacy Plug 'dracula/vim', { 'as': 'dracula' }

	# https://github.com/joshdick/onedark.vim
	legacy Plug 'joshdick/onedark.vim'

	# https://github.com/catppuccin/nvim
	legacy Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

	# other themes:
	# https://github.com/rafi/awesome-vim-colorschemes
	# https://github.com/sainnhe/sonokai



	###############################
	##### FILESYSTEM EXPLORER #####
	###############################
	# https://github.com/preservim/nerdtree
	legacy Plug 'preservim/nerdtree'

	### unicode icons for the explorer
	# https://github.com/ryanoasis/vim-devicons
	legacy Plug 'ryanoasis/vim-devicons'



	###############################
	##### FILE/SYMBOL SEARCH ######
	###############################
	# https://github.com/junegunn/fzf.vim
	# 'do' is used for plugins that require extra steps after installation/update
	# fzf (yes, the cmdline binary) get's installed first and then its vim plugin
	legacy Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	legacy Plug 'junegunn/fzf.vim'



	######################
	####### LSP ##########
	######################
	### The best lsp ever
	# https://github.com/prabirshrestha/vim-lsp
	legacy Plug 'prabirshrestha/vim-lsp'

	# https://github.com/mattn/vim-lsp-settings
	# legacy Plug 'mattn/vim-lsp-settings'

	### Autocompletion
	# https://github.com/prabirshrestha/asyncomplete.vim
	legacy Plug 'prabirshrestha/asyncomplete.vim'
	# https://github.com/prabirshrestha/asyncomplete-lsp.vim
	legacy Plug 'prabirshrestha/asyncomplete-lsp.vim'

	### Snippers
	# vim-vsnip integrates with 'vimlsp'
	# https://github.com/hrsh7th/vim-vsnip
	legacy Plug 'hrsh7th/vim-vsnip'
	# https://github.com/hrsh7th/vim-vsnip-integ
	legacy Plug 'hrsh7th/vim-vsnip-integ'
	# https://github.com/rafamadriz/friendly-snippets
	legacy Plug 'rafamadriz/friendly-snippets'

	# ultisnips integrates with 'asyncomplete'
	# if has('python3')
	# 		# https://github.com/SirVer/ultisnips
	# 		Plug 'SirVer/ultisnips'
	# 		# https://github.com/honza/vim-snippets
	# 		Plug 'honza/vim-snippets'
	# 		# https://github.com/prabirshrestha/asyncomplete-ultisnips.vim
	# 		Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
	# endif

	### Autoimport
	# See vimlsp



	#######################
	####### LINTING #######
	#######################
	# WARNING: ALE does not work as a source to asyncomplete by default, only
	# with the 'asyncomplete-ale' plugin bridge.
	# ALE brings linting to vim by bridging external linters to the editor.
	# ALE can work as a language server client (similar to vim-lsp) and also
	# display warnings/errors coming from language servers but it does not
	# provide sources to asyncomplete (by default).
	# With that in mind, ALE and vimlsp work separately and might even clash
	# when displaying error messages. This can be surpassed by disabling the
	# ALE's capabilities associated with language servers and letting only
	# 'vimlsp' receive information coming from language servers.

	# https://github.com/dense-analysis/ale
	# g:ale_disable_lsp = 1
	# legacy Plug 'dense-analysis/ale'
	# https://github.com/rhysd/vim-lsp-ale
	# legacy Plug 'rhysd/vim-lsp-ale'
	# https://github.com/andreypopp/asyncomplete-ale.vim
	# legacy Plug 'andreypopp/asyncomplete-ale.vim'



	#########################
	####### FORMATTER #######
	#########################
	# See ALE



	########################
	#### COMMENT TOGGLE ####
	########################
	# https://github.com/preservim/nerdcommenter
	# legacy Plug 'preservim/nerdcommenter'



	##########################
	#### AUTOMATIC TYPING ####
	##########################
	# https://github.com/tpope/vim-surround
	# Plug 'tpope/vim-surround'

	# https://github.com/tpope/vim-endwise
	legacy Plug 'tpope/vim-endwise'



	###########################
	##### GIT INTEGRATION #####
	###########################
	# https://github.com/tpope/vim-fugitive
	# legacy Plug 'tpope/vim-fugitive'

	# https://github.com/junegunn/gv.vim
	# legacy Plug 'junegunn/gv.vim'



	#################
	##### LP/ML #####
	#################
	### Rust
	# https://github.com/rust-lang/rust.vim
	# legacy Plug 'rust-lang/rust.vim'

	### Markdown
	# https://github.com/preservim/vim-markdown
	# legacy Plug 'godlygeek/tabular'
	# legacy Plug 'preservim/vim-markdown'
	
	# https://github.com/mzlogin/vim-markdown-toc
	legacy Plug 'mzlogin/vim-markdown-toc'

	### HTML
	# https://github.com/alvan/vim-closetag
	legacy Plug 'alvan/vim-closetag'
	
	### CSS
	# https://github.com/ap/vim-css-color
	legacy Plug 'ap/vim-css-color'

	### Latex
	# https://github.com/lervag/vimtex
	# legacy Plug 'lervag/vimtex'



	########################
	###### STATUS BAR ######
	########################
	# https://github.com/itchyny/lightline.vim
	# legacy Plug 'itchyny/lightline.vim'

	# https://github.com/vim-airline/vim-airline
	legacy Plug 'vim-airline/vim-airline'

	# https://github.com/vim-airline/vim-airline-themes#vim-airline-themes--
	legacy Plug 'vim-airline/vim-airline-themes'



	################
	##### MISC #####
	################
	# https://github.com/mhinz/vim-startify.git
	# legacy Plug 'mhinz/vim-startify'

	# https://github.com/preservim/tagbar
	# legacy Plug 'preservim/tagbar'

	# https://github.com/mbbill/undotree
	# legacy Plug 'mbbill/undotree'

	# https://github.com/rhysd/vim-healthcheck
	# legacy Plug 'rhysd/vim-healthcheck'
	
	# https://github.com/wolandark/vim-live-server
	# legacy Plug 'wolandark/vim-live-server'
	
	# The ollama installation script considers a system which uses systemd as
	# the init system and that has a GPU. In my case, i don't use systemd and
	# neither use a GPU (i have one, but i don't have its driver installed)
	# https://github.com/ollama/ollama
	# https://github.com/gergap/vim-ollama
	# legacy Plug 'https://github.com/gergap/vim-ollama'
	


	##################################
	#### PLUGINS I WOULDN'T USE,  ####
	#### BUT WHICH ARE KINDA COOL ####
	##################################
	# Autocompletion alternative to asyncomplete:
	# Arguably more robust then asyncomplete
	# Written in python
	# https://github.com/Shougo/deoplete.nvim
	
	# Replacement for deoplete (it won't be developed anymore)
	# Written in typescript
	# https://github.com/Shougo/ddc.vim
	
	# LSP alternative to vimlsp
	# Also provides automatic language server download
	# Written in typescript
	# https://github.com/neoclide/coc.nvim



	# " Call plug#end to update &runtimepath and initialize the plugin system.
	# " - It automatically executes `filetype plugin indent on` and `syntax enable`
	g:plug#end()
enddef
