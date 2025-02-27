-- https://github.com/rafamadriz/friendly-snippets 
-- https://github.com/garymjr/nvim-snippets
-- https://github.com/L3MON4D3/LuaSnip

return {
	{
		"rafamadriz/friendly-snippets"
	},
	{
		"garymjr/nvim-snippets",
		opts = {
			friendly_snippets = true,
			create_cmp_source = true,
		},
		keys = {
			{
				"<Tab>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<Tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<S-Tab>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
}
