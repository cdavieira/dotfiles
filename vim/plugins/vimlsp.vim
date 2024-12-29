vim9script

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
	'cmd': ['vim-language-server', '--stdio'],
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
	'cmd': 'typescript-language-server --stdio',
	'root_uri': (server_info) => lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')),
	'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact']
}
var js_lsp_info = {
	'name': 'javascript support using typescript-language-server',
	'cmd': (server_info) => [&shell, &shellcmdflag, 'typescript-language-server --stdio'],
	'root_uri': (server_info) => lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json')),
	'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
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
