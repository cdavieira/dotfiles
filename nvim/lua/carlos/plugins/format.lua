return {
	-- https://github.com/stevearc/conform.nvim
	-- Brings support for external formatters
	{
		'stevearc/conform.nvim',
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					-- lua = { "stylua" },

					-- Conform will run multiple formatters sequentially
					-- python = { "isort", "black" },

					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },

					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},

				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},

				-- Conform will notify you when a formatter errors
				notify_on_error = true,

				-- Conform will notify you when no formatters are available for the buffer
				notify_no_formatters = true,
			})
		end,
	},

	-- https://github.com/Vonr/align.nvim.git
	-- Manual text alignment
	{
		'Vonr/align.nvim',
		branch = "v2",
		lazy = true,
		init = function()
			-- Create your mappings here
		end
	}
}
