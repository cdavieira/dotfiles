vim9script

# since i use 'vimlsp' as the plugin for managing language servers, there's no
# need for ale to do the same thing:
g:ale_disable_lsp = 1

# from 'ale.txt' (':help ale.txt'):
# ALE also offers its own completion implementation, which does not require any
# other plugins. Suggestions will be made while you type after completion is
# enabled. ALE's own completion implementation can be enabled by setting
# |g:ale_completion_enabled| to `true` or `1`. This setting must be set to
# `true` or `1` before ALE is loaded. The delay for completion can be configured
# with |g:ale_completion_delay|. This setting should not be enabled if you wish
# to use ALE as a completion source for other plugins.
#
# since i use 'asyncomplete' as the plugin for asynchronous completion,
# there's no need to overload ale with that:
g:ale_completion_enabled = 0

g:ale_lint_on_text_changed = false

g:ale_lint_on_insert_leave = true

g:ale_lint_on_enter = true

g:ale_lint_on_save = true

g:ale_lint_on_filetype_changed = true

g:ale_echo_cursor = 1

g:ale_linters_explicit = true

g:ale_c_clangformat_use_local_file = 1

g:ale_linters = {
      'c': ['clangtidy', 'cppcheck'],
      'rust': ['analyzer', 'cargo', 'clippy'],
      'javascript': ['eslint'],
      'lua': ['luacheck'],
      'python': ['flake8', 'mypy', 'pylint', 'pyright'],
      'json': ['jsonlint'],
      'yaml': ['yamllint'],
}

	# 'c': ['astyle', 'clang-format', 'clangtidy'],
g:ale_fixers = {
	'*': ['remove_trailing_lines', 'trim_whitespace'],
	'c': ['clang-format'],
	'rust': ['rustfmt'],
	'javascript': ['eslint'],
	'json': ['prettier'],
	'yaml': ['prettier'],
}
