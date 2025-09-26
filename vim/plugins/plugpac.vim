vim9script

# Notes about the following vim9plugin:
#
# Take a look on how to setup plugpac first:
# https://github.com/bennyyip/plugpac.vim
#
# Plugpac is a thin layer over minpac. It's written in vim9.
#
# minpac works by leveraging the builtin package system of vim.
#
# In that regard, minpac installs new plugins in the typical 'pack/'
# directory of vim and manages them there. Enabled plugins are organized in
# the 'start/' directory and disabled ones go to 'opt/'. plugpac itself is
# located in the 'opt/' folder and requires being added through 'packadd' in
# order to expose its commands (Pack, ...)
#
# The 'vim9lsp' plugin is simpler than 'vimlsp'. It only requires registering
# new language servers and that's it. No autocommand needed or anything. The
# only inconvenient is that the 'lsp' package has to be loaded with 'packadd
# lsp' in order to use the g:LspAddServer function
#
# OBS: not all plugins found here are actually written in vim9. Some were
# spared from this requirement, because they are perfect the way they are!

export def NormalSetup()
	plugpac#Begin({
	  status_open: 'vertical',
	  verbose: 2,
	  quiet: v:false, # show no warning if any package is not installed
	})

	# File explorer
	plugpac#Add('ryanoasis/vim-devicons')

	## No treeview/sidepanel
	plugpac#Add('habamax/vim-dir')

	## Sidepanel
	# plugpac#Add('nda-cunh/SupraTree')

	# Fuzzy finder
	# plugpac#Add('vim-fuzzbox/fuzzbox.vim')

	# LSP
	plugpac#Add('yegappan/lsp')

	# Autocompletion
	# :h ins-autocompletion
	# :h ins-autocompletion-example

	# Snippers
	# 'hrsh7th/vim-vsnip'
	# 'hrsh7th/vim-vsnip-integ'
	# 'rafamadriz/friendly-snippets'

	# Formatter
	# 'junegunn/vim-easy-align'

	# Auto typing 
	# 'tpope/vim-commentary'
	# 'tpope/vim-surround'
	# 'tpope/vim-endwise'
	# 'jiangmiao/auto-pairs'
	# plugpac#Add('ubaldot/vim-op-surround')

	### Git
	# 'tpope/vim-fugitive'
	# 'airblade/vim-gitgutter'
	# 'junegunn/gv.vim'

	### Other
	plugpac#Add('kshenoy/vim-signature')
	plugpac#Add('romainl/vim-cool')
	plugpac#Add('roxma/vim-paste-easy')
	# plugpac#Add('bfrg/vim-qf-diagnostics')
	# plugpac#Add('bfrg/vim-qf-preview')

	plugpac#End()
enddef
