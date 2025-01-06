vim9script

g:ale_disable_lsp = 1
g:ale_fixers = {
	'*': ['remove_trailing_lines', 'trim_whitespace'],
	'javascript': ['eslint'],
}
