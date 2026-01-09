-- https://github.com/mfussenegger/nvim-lint

return {
	"mfussenegger/nvim-lint",
	enabled = true,
	config = function()
		require('lint').linters_by_ft = {
			javascript = { 'eslint' },
			typescriptreact = { 'eslint' },
			typescript = { 'eslint' },
		}
	end
}
