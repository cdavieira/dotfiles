-- lspconfig
-- https://github.com/neovim/nvim-lspconfig
-- Preconfigure language servers easily

-- lsp_signature
-- https: https://github.com/ray-x/lsp_signature.nvim
-- This plugin makes ballons appear with the signature of a function and its parameters after you accept a suggestion from the autocompleter

-- neodev
-- https://github.com/folke/neodev.nvim
-- Neovim setup for init.lua and plugin development with full signature help,
-- docs and completion for the nvim lua API.
return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require'lsp_signature'.setup(opts) end
	},
	{
		"folke/neodev.nvim",
		opts = {}
	}
}
