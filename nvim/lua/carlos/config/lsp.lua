local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities
})

vim.lsp.enable({'pylsp', 'lua_ls', 'clangd', 'ts_ls', 'rust_analyzer'})
