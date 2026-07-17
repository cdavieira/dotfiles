vim9script

autocmd BufEnter *.c {
  set commentstring=//\ %s
}

# autocmd! BufWritePre *.rs execute('LspDocumentFormatSync')
