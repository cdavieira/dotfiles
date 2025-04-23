-- require('java').setup()

Lspconfig = require('lspconfig')
Lspconfig.pylsp.setup {}
Lspconfig.lua_ls.setup {}
Lspconfig.clangd.setup {}
Lspconfig.ts_ls.setup {}
Lspconfig.rust_analyzer.setup {
	settings = { -- Server-specific settings. See `:help lspconfig-setup`
		['rust-analyzer'] = {},
	},
}
-- Lspconfig.jdtls.setup({})
