-- Plugins will be added here accordingly.

--[[
	[X] lazy
		https://github.com/folke/lazy.nvim
	[X] telescope
		https://github.com/nvim-telescope/telescope.nvim
	[X] telescope-fzf-native
		https://github.com/nvim-telescope/telescope-fzf-native.nvim
	[X] nvim-treesitter
		https://github.com/nvim-treesitter/nvim-treesitter
	[X] lspconfig
		https://github.com/neovim/nvim-lspconfig
	[X] neotree
		https://github.com/nvim-neo-tree/neo-tree.nvim
	[ ] ripgrep
		https://github.com/BurntSushi/ripgrep
	[ ] fd
		https://github.com/sharkdp/fd
--]]




--[[
	MORE: https://github.com/topics/neovim-colorscheme
	[X] https://github.com/catppuccin/nvim
	[ ] https://github.com/folke/tokyonight.nvim
--]]


return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim'
		}
	}, 
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&' ..
				'cmake --build build --config Release &&' ..
				'cmake --install build --prefix build'
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"python",
				"javascript",
				"typescript",
				"rust"
				-- "html"
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
		end 
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},
	{
		"neovim/nvim-lspconfig"
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require'lsp_signature'.setup(opts) end
	}
}
