Lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

Lspconfig.pylsp.setup {
  capabilities = capabilities
}

Lspconfig.lua_ls.setup {
  capabilities = capabilities
}

Lspconfig.clangd.setup {
  capabilities = capabilities
}

Lspconfig.ts_ls.setup {
  capabilities = capabilities
}

Lspconfig.rust_analyzer.setup {
  settings = { -- Server-specific settings. See `:help lspconfig-setup`
	  ['rust-analyzer'] = {},
  },
  capabilities = capabilities
}
