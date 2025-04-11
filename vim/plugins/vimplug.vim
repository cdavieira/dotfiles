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

	# If one day i get tired of configuring vim myself,
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
	### The best language server client ever
	# https://github.com/prabirshrestha/vim-lsp
	legacy Plug 'prabirshrestha/vim-lsp'

	### Automatic language server download/configuration for vimlsp
	# https://github.com/mattn/vim-lsp-settings
	# legacy Plug 'mattn/vim-lsp-settings'

	### Autoimport
	# See vimlsp



	#######################
	####### LINTING #######
	#######################
	# ALE brings linting to vim by bridging external linters to the editor.
	#
	# ALE can work as a language server client (similar to vim-lsp) and also
	# display warnings/errors coming from language servers (and from
	# linters as well)
	#
	# With that in mind, ALE and vimlsp work separately and might even clash
	# when displaying error messages. This can be surpassed by disabling ALE's
	# capabilities associated with language servers and letting only 'vimlsp'
	# receive information coming from language servers.
	#
	# ALE also works together with gitgutter to display warnings/error
	# (W/E) signs in the sign column
	#
	# I personally use ale only for its linting and fixing capabilities,
	# letting 'vimlsp' bring the LSP functionality into vim.

	# https://github.com/dense-analysis/ale
	legacy Plug 'dense-analysis/ale'

	# https://github.com/rhysd/vim-lsp-ale
	# legacy Plug 'rhysd/vim-lsp-ale'



	#######################
	### AUTO COMPLETION ###
	#######################
	# asyncomplete deliberately does not contain any sources. And....
	# What's a source you ask?
	#
	# A source is a program/external tool which provides suggestions that
	# will appear while you type. 
	#
	# Different things serve as sources:
	# 1. language servers (such as clangd)
	# 2. snippers
	# 3. tag files
	# 4. even vim functions that return arbitrary suggestions!
	#
	# plugins like 'vimlsp' (lsp capability), 'ale' (lsp capability),
	# 'vsnip' (snipper) and others require some tweaks to integrate with
	# asyncomplete. These tweaks come in the form of plugin bridges, which
	# do all the work of integrating both plugins for you.

	# https://github.com/prabirshrestha/asyncomplete.vim
	legacy Plug 'prabirshrestha/asyncomplete.vim'

	# 'vimlsp' and 'asyncomplete' integration
	# https://github.com/prabirshrestha/asyncomplete-lsp.vim
	legacy Plug 'prabirshrestha/asyncomplete-lsp.vim'
	
	# 'ale' and 'asyncomplete' integration
	# OBS: i personally don't use ale as an LSP, therefore i don't need
	# this plugin. But, maybe its worth giving it a shot someday!
	# https://github.com/andreypopp/asyncomplete-ale.vim
	# legacy Plug 'andreypopp/asyncomplete-ale.vim'

	# 'flow' and 'asyncomplete' integration
	# https://github.com/prabirshrestha/asyncomplete-flow.vim
	# legacy Plug 'prabirshrestha/asyncomplete-flow.vim'

	# 'emmet' and 'asyncomplete' integration
	# OBS: you also need 'emmet-vim' for this!
	# https://github.com/prabirshrestha/asyncomplete-emmet.vim
	# legacy Plug 'prabirshrestha/asyncomplete-emmet.vim'

	# 'filesystem' and 'asyncomplete' integration
	# https://github.com/prabirshrestha/asyncomplete-file.vim
	legacy Plug 'prabirshrestha/asyncomplete-file.vim'

	# 'ultisnips' and 'asyncomplete' integration
	# OBS: 'ultisnips' is an alternative to 'vsnip' (the one i use)
	# https://github.com/prabirshrestha/asyncomplete-ultisnips.vim
	# legacy Plug 'prabirshrestha/asyncomplete-ultisnips.vim'



	#######################
	####### SNIPPER #######
	#######################
	# vim-vsnip integrates with 'vimlsp', and 'vimlsp' integrates with
	# 'asyncomplete'. Therefore, 'asyncomplete' will show all snippets
	# that 'vim-vsnip' provides.
	#
	# https://github.com/hrsh7th/vim-vsnip
	legacy Plug 'hrsh7th/vim-vsnip'
	# https://github.com/hrsh7th/vim-vsnip-integ
	legacy Plug 'hrsh7th/vim-vsnip-integ'
	# https://github.com/rafamadriz/friendly-snippets
	legacy Plug 'rafamadriz/friendly-snippets'

	# ultisnips is also pretty good:
	# https://github.com/SirVer/ultisnips
	# OBS: it can be integrated directly into 'asyncomplete'!



	#########################
	####### FORMATTER #######
	#########################
	# See vimlsp
	# See ALE

	# https://github.com/vim-autoformat/vim-autoformat
	# legacy Plug 'vim-autoformat/vim-autoformat'

	# https://github.com/google/vim-codefmt
	# legacy Plug 'google/vim-codefmt'




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
	legacy Plug 'airblade/vim-gitgutter'

	# https://github.com/junegunn/gv.vim
	legacy Plug 'junegunn/gv.vim'

	# https://github.com/rhysd/git-messenger.vim
	# legacy Plug 'rhysd/git-messenger.vim'

	### jq
	# https://github.com/bfrg/vim-jq
	# legacy Plug 'bfrg/vim-jq'

	# https://github.com/bfrg/vim-jqplay
	# legacy Plug 'bfrg/vim-jqplay'
	
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
	
	### tmux
	# https://github.com/christoomey/vim-tmux-navigator
	# legacy Plug 'christoomey/vim-tmux-navigator'

	# https://github.com/preservim/vimux
	# legacy Plug 'preservim/vimux'
	
	# https://github.com/edkolev/tmuxline.vim
	# legacy Plug 'edkolev/tmuxline.vim'

	### Emmet
	# https://github.com/mattn/emmet-vim
	# legacy Plug 'mattn/emmet-vim'



	#################
	##### PL/ML #####
	#################
	### Rust
	# https://github.com/rust-lang/rust.vim
	# legacy Plug 'rust-lang/rust.vim'
	
	### Go
	# https://github.com/fatih/vim-go
	# legacy Plug 'fatih/vim-go'

	### Markdown
	# https://github.com/preservim/vim-markdown
	legacy Plug 'godlygeek/tabular'
	legacy Plug 'preservim/vim-markdown'
	
	# https://github.com/mzlogin/vim-markdown-toc
	# legacy Plug 'mzlogin/vim-markdown-toc'

	### HTML
	# https://github.com/alvan/vim-closetag
	legacy Plug 'alvan/vim-closetag'
	
	### CSS
	# https://github.com/ap/vim-css-color
	legacy Plug 'ap/vim-css-color'

	### Latex
	# https://github.com/lervag/vimtex
	# legacy Plug 'lervag/vimtex'
	
	# https://github.com/xuhdev/vim-latex-live-preview
	# legacy Plug 'xuhdev/vim-latex-live-preview'
	
	### Javascript
	# https://github.com/pangloss/vim-javascript
	# legacy Plug 'pangloss/vim-javascript'
	
	# https://github.com/HerringtonDarkholme/yats.vim
	legacy Plug 'HerringtonDarkholme/yats.vim'

	# https://github.com/mxw/vim-jsx
	legacy Plug 'mxw/vim-jsx'

	# https://github.com/othree/javascript-libraries-syntax.vim
	# legacy Plug 'othree/javascript-libraries-syntax.vim'

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
	# legacy Plug 'gergap/vim-ollama'

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

	# https://github.com/chrisbra/csv.vim
	legacy Plug 'chrisbra/csv.vim'

	# https://github.com/fredkschott/covim
	# legacy Plug 'fredkschott/covim'

	# toggle 'paste' automatically when pasting something external from vim
	# https://github.com/roxma/vim-paste-easy
	# legacy Plug 'roxma/vim-paste-easy'

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
