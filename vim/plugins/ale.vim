vim9script

# disable any lsp capability, as i use 'vimlsp' for that
g:ale_disable_lsp = 1

# disable any (asynchronous) autocompletion capability, as i use 'asyncomplete' for that
g:ale_completion_enabled = 0

# set when ale should display W/E messages
g:ale_lint_on_text_changed = false
g:ale_lint_on_insert_leave = true
g:ale_lint_on_enter = true
g:ale_lint_on_save = true
g:ale_lint_on_filetype_changed = true

# echo the W/E message in the command mode bar
g:ale_echo_cursor = 1
g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

# disallow ale from running any other linter/fixer than those explicitly
# defined with 'ale_linters' and 'ale_fixers'
g:ale_linters_explicit = true

# linter/fixer setup
g:ale_c_clangformat_use_local_file = 1

# OBS: to get a list of possible linters and fixers for a filetype: ':ALEInfo'
g:ale_linters = {
      'c': ['clangtidy', 'cppcheck'],
      'rust': ['analyzer', 'cargo', 'clippy'],
      'javascript': ['eslint'],
      'typescriptreact': ['eslint'],
      'lua': ['luacheck'],
      'python': ['flake8', 'mypy', 'pylint', 'pyright'],
      'json': ['jsonlint'],
      'yaml': ['yamllint'],
}

# OBS: all fixers run senquentially
g:ale_fixers = {
	'*': ['remove_trailing_lines', 'trim_whitespace'],
	'c': ['clang-format'],
	'rust': ['rustfmt'],
	'javascript': ['eslint'],
	'typescriptreact': ['eslint'],
	'json': ['prettier'],
	'yaml': ['prettier'],
}
