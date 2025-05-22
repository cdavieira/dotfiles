-- https://github.com/rafamadriz/friendly-snippets 
-- https://github.com/L3MON4D3/LuaSnip

return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		end,
	},
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	build = "make install_jsregexp",
}
