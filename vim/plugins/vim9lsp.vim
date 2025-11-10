vim9script

# The 'vim9lsp' plugin is simpler than 'vimlsp'. It only requires registering
# new language servers and that's it. No autocommand needed or anything. The
# only inconvenient is that the 'lsp' package has to be loaded with 'packadd
# lsp' in order to use the g:LspAddServer function

# packadd lsp

var clangd = {
	'name': 'clangd',
	'filetype': ['c', 'cpp'],
	'path': '/usr/lib/llvm/20/bin/clangd',
	'args': ['--background-index'],
}

var servers = [
	clangd
]

g:LspAddServer(servers)
