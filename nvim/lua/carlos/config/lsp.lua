local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
	capabilities = capabilities
})

vim.lsp.config['solidity-ls'] = {
	-- Command and arguments to start the server.
	cmd = { 'solidity-ls', '--stdio' },
	-- Filetypes to automatically attach to.
	filetypes = { 'solidity' },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { 'package.json' }, '.git' },
	-- on_attach = on_attach, -- probably you will need this.
	-- capabilities = capabilities,
	settings = {
		-- example of global remapping
		solidity = {
			includePath = '',
			remapping = {
				["@OpenZeppelin/"] = 'OpenZeppelin/openzeppelin-contracts@4.6.0/'
			},
			-- Array of paths to pass as --allow-paths to solc
			allowPaths = {}
		}
	},
}

vim.lsp.enable({
	'pylsp',
	'lua_ls',
	'clangd',
	'ts_ls',
	'rust_analyzer',
	'solidity-ls',
})
