vim9script

type Dirpath = string

export def MinimalSetup(vimplug_dir: Dirpath)
	g:plug#begin(vimplug_dir)

	# File explorer
	legacy Plug 'preservim/nerdtree'

	# Fuzzy finder
	legacy Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	legacy Plug 'junegunn/fzf.vim'

	# LSP
	legacy Plug 'prabirshrestha/vim-lsp'

	g:plug#end()
enddef

export def NormalSetup(vimplug_dir: Dirpath)
	g:plug#begin(vimplug_dir)

	# File explorer
	legacy Plug 'preservim/nerdtree'

	# Fuzzy finder
	legacy Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	legacy Plug 'junegunn/fzf.vim'

	# LSP
	legacy Plug 'prabirshrestha/vim-lsp'

	# LSP: Autocompletion
	legacy Plug 'prabirshrestha/asyncomplete.vim'
	legacy Plug 'prabirshrestha/asyncomplete-lsp.vim'

	# Snippers
	legacy Plug 'hrsh7th/vim-vsnip'
	legacy Plug 'hrsh7th/vim-vsnip-integ'
	legacy Plug 'rafamadriz/friendly-snippets'

	g:plug#end()
enddef

export def FullSetup(vimplug_dir: Dirpath)
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

	### Automatic language server download/configuration for vimlsp
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
	# ultisnips is also pretty good: https://github.com/SirVer/ultisnips

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
	# when displaying error messages. This can be surpassed by disabling ALE's
	# capabilities associated with language servers and letting only 'vimlsp'
	# receive information coming from language servers.
	# https://github.com/dense-analysis/ale
	# legacy Plug 'dense-analysis/ale'
	# https://github.com/rhysd/vim-lsp-ale
	# legacy Plug 'rhysd/vim-lsp-ale'
	# https://github.com/andreypopp/asyncomplete-ale.vim
	# legacy Plug 'andreypopp/asyncomplete-ale.vim'



	#########################
	####### FORMATTER #######
	#########################
	# See vimlsp
	# See ALE



	########################
	#### COMMENT TOGGLE ####
	########################
	# https://github.com/preservim/nerdcommenter
	# legacy Plug 'preservim/nerdcommenter'
	
	# https://github.com/tpope/vim-commentary
	legacy Plug 'tpope/vim-commentary'



	##########################
	#### AUTOMATIC TYPING ####
	##########################
	# https://github.com/tpope/vim-surround
	legacy Plug 'tpope/vim-surround'

	# https://github.com/tpope/vim-endwise
	legacy Plug 'tpope/vim-endwise'
	
	# https://github.com/jiangmiao/auto-pairs
	legacy Plug 'jiangmiao/auto-pairs'



	############################
	##### TOOL INTEGRATION #####
	############################
	### Git
	# https://github.com/tpope/vim-fugitive
	legacy Plug 'tpope/vim-fugitive'

	# https://github.com/airblade/vim-gitgutter
	# legacy Plug 'airblade/vim-gitgutter'

	# https://github.com/junegunn/gv.vim
	# legacy Plug 'junegunn/gv.vim'
	
	### Databases
	# https://github.com/tpope/vim-dadbod
	# legacy Plug 'tpope/vim-dadbod'
	
	### Ctags
	# https://github.com/preservim/tagbar
	legacy Plug 'preservim/tagbar'

	# https://github.com/ludovicchabant/vim-gutentags
	# legacy Plug 'ludovicchabant/vim-gutentags'

	# https://github.com/craigemery/vim-autotag
	# legacy Plug 'craigemery/vim-autotag'

	# https://github.com/soramugi/auto-ctags.vim
	# legacy Plug 'soramugi/auto-ctags.vim'

	# https://github.com/szw/vim-tags
	# legacy Plug 'szw/vim-tags'
	
	### Jupyter
	# https://github.com/ubaldot/vim-replica
	# legacy Plug 'ubaldot/vim-replica'

	### GPG
	# https://github.com/jamessan/vim-gnupg
	# legacy Plug 'jamessan/vim-gnupg'


	#################
	##### PL/ML #####
	#################
	### Rust
	# https://github.com/rust-lang/rust.vim
	# legacy Plug 'rust-lang/rust.vim'

	### Markdown
	# https://github.com/preservim/vim-markdown
	legacy Plug 'godlygeek/tabular'
	legacy Plug 'preservim/vim-markdown'
	
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
	
	### Javascript
	# https://github.com/pangloss/vim-javascript
	legacy Plug 'pangloss/vim-javascript'
	
	# https://github.com/HerringtonDarkholme/yats.vim
	legacy Plug 'HerringtonDarkholme/yats.vim'

	# https://github.com/mxw/vim-jsx
	legacy Plug 'mxw/vim-jsx'

	### Solidity
	# https://github.com/tomlion/vim-solidity
	# legacy Plug 'tomlion/vim-solidity'

	# https://github.com/juanfranblanco/vscode-solidity
	# legacy Plug 'juanfranblanco/vscode-solidity'



	########################
	###### STATUS BAR ######
	########################
	# https://github.com/itchyny/lightline.vim
	# legacy Plug 'itchyny/lightline.vim'

	# https://github.com/vim-airline/vim-airline
	legacy Plug 'vim-airline/vim-airline'

	# https://github.com/vim-airline/vim-airline-themes
	legacy Plug 'vim-airline/vim-airline-themes'



	##############
	##### AI #####
	##############
	# The ollama installation script considers a system which uses systemd as
	# the init system and that has a GPU. In my case, i don't use systemd and
	# neither use a GPU (i have one, but i don't have its driver installed)
	# https://github.com/ollama/ollama
	# https://github.com/gergap/vim-ollama
	legacy Plug 'gergap/vim-ollama'

	# https://github.com/CoderCookE/vim-chatgpt
	# legacy Plug 'CoderCookE/vim-chatgpt'

	# https://github.com/github/copilot.vim
	# legacy Plug 'github/copilot.vim'

	# https://github.com/skywind3000/vim-gpt-commit
	# legacy Plug 'skywind3000/vim-gpt-commit'



	################
	##### MISC #####
	################
	# https://github.com/mhinz/vim-startify.git
	legacy Plug 'mhinz/vim-startify'

	# https://github.com/romainl/vim-cool
	legacy Plug 'romainl/vim-cool'

	# https://github.com/terryma/vim-smooth-scroll
	# legacy Plug 'terryma/vim-smooth-scroll'

	# https://github.com/mbbill/undotree
	# legacy Plug 'mbbill/undotree'

	# https://github.com/rhysd/vim-healthcheck
	# legacy Plug 'rhysd/vim-healthcheck'
	
	# https://github.com/wolandark/vim-live-server
	# legacy Plug 'wolandark/vim-live-server'
	
	# https://github.com/voldikss/vim-floaterm
	# legacy Plug 'voldikss/vim-floaterm'

	# https://github.com/easymotion/vim-easymotion
	# legacy Plug 'easymotion/vim-easymotion'
	
	# https://github.com/kana/vim-textobj-user
	# legacy Plug 'kana/vim-textobj-user'

	# https://github.com/vimwiki/vimwiki
	# legacy Plug 'vimwiki/vimwiki'

	# https://github.com/qadzek/link.vim.git
	# legacy Plug 'qadzek/link.vim.git'

	# https://github.com/gyim/vim-boxdraw
	# legacy Plug 'gyim/vim-boxdraw'
	
	# https://github.com/jessepav/vim-boxdraw
	# legacy Plug 'jessepav/vim-boxdraw'

	# https://github.com/luochen1990/rainbow
	# legacy Plug 'luochen1990/rainbow'
	
	# https://github.com/junegunn/vim-easy-align
	# legacy Plug 'junegunn/vim-easy-align'

	# https://github.com/inkarkat/vim-mark
	# legacy Plug 'inkarkat/vim-mark'

	# https://github.com/kshenoy/vim-signature
	# legacy Plug 'kshenoy/vim-signature'

	# https://github.com/vim-scripts/LargeFile
	# legacy Plug 'vim-scripts/LargeFile'

	# https://github.com/lambdalisue/vim-suda
	# legacy Plug 'lambdalisue/vim-suda'

	# " Call plug#end to update &runtimepath and initialize the plugin system.
	# " - It automatically executes `filetype plugin indent on` and `syntax enable`
	g:plug#end()
enddef
