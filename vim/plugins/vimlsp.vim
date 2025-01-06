vim9script

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



#############################################################
######################## LSP CONFIG #########################
#############################################################
# Steps to configure a new LSP:
#
# Step 1: create a dictionary based on one of the ones found below to inform
# how the LSP server should be initialized
#
# Step 2: create an autocmd to register the language server and set it upon
# opening a file of a certain programming language
#
# Step 3: create one or more autocmds to setup mappings and options upon
# opening files

########################
######## STEP 1 ########
########################
# this dictionary also accepts the keys:
# 'root_uri' (a string), 'capabilities', 'initialization_options'
# you can check this by reading '~/.config/vim/vim-plug/vim-lsp/autoload/lsp.vim'
var c_lspinfo = {
	'name': 'clangd',
	'cmd': ['clangd', '--background-index'],
	'allowlist': ['c', 'cpp'],
	'blocklist': [],
	'config': {},
	'workspace_config': {}
}
var lua_lspinfo = {
	'name': 'lua-language-server',
	'cmd': ['lua-language-server', '--stdio'],
	'allowlist': ['lua'],
	'blocklist': [],
	'config': {},
	'workspace_config': {}
}
var python_lspinfo = {
	'name': 'pylsp',
	'cmd': ['pylsp'],
	'allowlist': ['python'],
	'blocklist': [],
	'config': {},
	'workspace_config': {}
}
var rust_lsp_info = {
	'name': 'rust-analyzer',
	'cmd': ['rust-analyzer'],
	'allowlist': ['rust'],
	'blocklist': [],
	'config': {},
	'workspace_config': {}
}
var vim_lsp_info = {
	'name': 'vim-language-server',
	'cmd': (server_info) => ['vim-language-server', '--stdio'],
	'allowlist': ['vim'],
	'initialization_options': {
		'vimruntime': $VIMRUNTIME,
		'runtimepath': &rtp
	},
	'blocklist': [],
	'config': {},
	'workspace_config': {}
}
var ts_lsp_info = {
	'name': 'typescript-language-server',
	'cmd': (server_info) => [&shell, &shellcmdflag, 'typescript-language-server --stdio'],
	'root_uri': (server_info) => lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')),
	'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact']
}
var js_lsp_info = {
	'name': 'javascript support using typescript-language-server',
	'cmd': (server_info) => [&shell, &shellcmdflag, 'typescript-language-server --stdio'],
	'root_uri': (server_info) => lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json')),
	'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
}
var html_lsp_info = {
	'name': 'html-languageserver',
	'cmd': (server_info) => [&shell, &shellcmdflag, 'html-languageserver --stdio'],
	'whitelist': ['html'],
}
var css_lsp_info = {
	'name': 'css-languageserver',
	'cmd': (server_info) => [&shell, &shellcmdflag, 'css-languageserver --stdio'],
	'whitelist': ['css', 'less', 'sass'],
}
var tex_lsp_info = {
	'name': 'texlab',
	'cmd': (server_info) => [expand('texlab')],
	'whitelist': ['tex']
}

########################
######## STEP 2 ########
########################
if executable('clangd')
	au User lsp_setup lsp#register_server(c_lspinfo)
endif
if executable('lua-language-server')
	au User lsp_setup lsp#register_server(lua_lspinfo)
endif
if executable('pylsp')
	au User lsp_setup lsp#register_server(python_lspinfo)
endif
if executable('rust-analyzer')
	au User lsp_setup lsp#register_server(rust_lsp_info)
endif
if executable('vim-language-server')
	au User lsp_setup lsp#register_server(vim_lsp_info)
endif
if executable('tsserver')
	au User lsp_setup lsp#register_server(ts_lsp_info)
	au User lsp_setup lsp#register_server(js_lsp_info)
endif
if executable('html-languageserver')
	au User lsp_setup lsp#register_server(html_lsp_info)
endif
if executable('css-languageserver')
	au User lsp_setup lsp#register_server(css_lsp_info)
endif
if executable('texlab')
	au User lsp_setup lsp#register_server(tex_lsp_info)
endif

########################
######## STEP 3 ########
########################
def On_lsp_buffer_enabled(): void
	setlocal omnifunc=lsp#complete
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

	# peek- infixable
  nnoremap <buffer> <leader>a <plug>(lsp-declaration)
	nnoremap <buffer> <leader>d <plug>(lsp-definition)
  nnoremap <buffer> <leader>g <plug>(lsp-implementation)
	nnoremap <buffer> <leader>t <plug>(lsp-type-definition)
  nnoremap <buffer> <leader>h <plug>(lsp-type-hierarchy)

	# -preview appendable
  nnoremap <buffer> <leader>k <plug>(lsp-hover)

	# nothing
  nnoremap <buffer> <leader>m <plug>(lsp-document-symbol)
  nnoremap <buffer> <leader>i <plug>(lsp-document-diagnostics)
  nnoremap <buffer> <leader>w <plug>(lsp-preview-focus)
  nnoremap <buffer> <leader>l <plug>(lsp-preview-close)
  nnoremap <buffer> <leader>j <plug>(lsp-rename)

	# retired
  # nnoremap <buffer> <leader>z <plug>(lsp-code-action)
  # nnoremap <buffer> <leader>y <plug>(lsp-references)
  # nnoremap <buffer> <leader>x <plug>(lsp-code-lens)
  # nnoremap <buffer> <leader>w <plug>(lsp-next-diagnostic)
  # nnoremap <buffer> <leader>v <plug>(lsp-next-error)
  # nnoremap <buffer> <leader>u <plug>(lsp-next-warning)
  # nnoremap <buffer> <leader>n <plug>(lsp-status)

	autocmd! BufWritePre *.rs execute('LspDocumentFormatSync')
enddef

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled On_lsp_buffer_enabled()
augroup END
