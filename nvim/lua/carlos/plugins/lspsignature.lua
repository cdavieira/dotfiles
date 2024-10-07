-- lsp

-- https://www.lazyvim.org/plugins/coding
-- https://github.com/hrsh7th/nvim-cmp

return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts) require'lsp_signature'.setup(opts) end
}
