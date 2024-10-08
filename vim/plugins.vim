vim9script

import './path.vim'

#############################################################
#################### PLUGIN VARIABLES #######################
#############################################################

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

# disallow NERDTree extension from creating unwanted mappings
g:NERDCreateDefaultMappings = 0

# abort `:LspDocumentFormatSync` or `:LspDocumentRangeFormatSync` after 1000ms
g:lsp_format_sync_timeout = 1000

# disable calling a custom function when over some text while the preview is still open
g:lsp_preview_doubletap = 0

# automatically close floating previews upon cursor movement
g:lsp_preview_autoclose = 1

# enable support for diagnostics like warnings and error messages
g:lsp_diagnostics_enabled = 1

# enable signs like W> and E> for diagnostics messages
g:lsp_diagnostics_signs_enabled = 1

# keep cursor focus on the document rather than on the preview-window when it
# pops up (ex: when hovering)
g:lsp_preview_keep_focus = 1

# [experimental] enables workspace capabilities when the lsp supports it by
# calling the function 'root_uri'.
#
# read ':h vim-lsp-workspace-folders' for details
# g:lsp_experimental_workspace_folders = 1

# create a log file to inspect lsp action
g:lsp_log_file = expand(path.vim_config_dir .. 'vim-lsp.log')

# create a log file to inspect async action
# g:asyncomplete_log_file = expand(vim_config_dir .. 'asyncomplete.log')


#############################################################
##################### PLUGIN MANAGER ########################
#############################################################

g:plug#begin(path.vimplug_dir)

# https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'

# https://github.com/ryanoasis/vim-devicons
Plug 'ryanoasis/vim-devicons'

# https://github.com/tpope/vim-surround
# Plug 'tpope/vim-surround'

# https://github.com/tpope/vim-endwise
Plug 'tpope/vim-endwise'

# https://github.com/junegunn/fzf.vim
# 'do' is used for plugins that require extra steps after installation/update
# fzf (yes, the cmdline binary) get's installed first and then its vim plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

# https://github.com/prabirshrestha/vim-lsp
Plug 'prabirshrestha/vim-lsp'

# https://github.com/prabirshrestha/asyncomplete.vim
Plug 'prabirshrestha/asyncomplete.vim'

# https://github.com/prabirshrestha/asyncomplete-lsp.vim
Plug 'prabirshrestha/asyncomplete-lsp.vim'

# https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

# https://github.com/itchyny/lightline.vim
# Plug 'itchyny/lightline.vim'

# https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

# https://github.com/vim-airline/vim-airline-themes#vim-airline-themes--
Plug 'vim-airline/vim-airline-themes'

# https://github.com/mbbill/undotree
# Plug 'mbbill/undotree'

# https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

# https://github.com/preservim/tagbar?tab=readme-ov-file
# Plug 'preservim/tagbar'

# https://github.com/preservim/vim-markdown
# Plug 'godlygeek/tabular'
# Plug 'preservim/vim-markdown'

# https://github.com/rhysd/vim-healthcheck
Plug 'rhysd/vim-healthcheck'

# https://github.com/morhetz/gruvbox?tab=readme-ov-file
# Plug 'morhetz/gruvbox'
# autocmd vimenter * ++nested colorscheme gruvbox

# https://draculatheme.com/vim
# https://github.com/dracula/dracula-theme
Plug 'dracula/vim', { 'as': 'dracula' }
# colorscheme dracula

# https://github.com/joshdick/onedark.vim
Plug 'joshdick/onedark.vim'
# colorscheme onedark

# other themes:
# https://github.com/rafi/awesome-vim-colorschemes
# https://github.com/sainnhe/sonokai

# " Call plug#end to update &runtimepath and initialize the plugin system.
# " - It automatically executes `filetype plugin indent on` and `syntax enable`
g:plug#end()
