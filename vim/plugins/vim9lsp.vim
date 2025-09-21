vim9script

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
