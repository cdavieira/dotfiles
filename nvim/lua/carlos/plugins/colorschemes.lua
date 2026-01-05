-- https://github.com/catppuccin/nvim
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			local themery = require("themery")
			themery.setup({
				themes = {
					'catppuccin',
					'habamax',
					'sorbet',
					'unokai',
					'zaibatsu',
					'zellner',
				},
				livePreview = true,
			})
		end
	},
}
