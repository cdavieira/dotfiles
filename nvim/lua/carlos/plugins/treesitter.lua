-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/windwp/nvim-ts-autotag

return {
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
	{ 'windwp/nvim-ts-autotag',
	  config = function ()
		  require('nvim-ts-autotag').setup({
		    opts = {
		      -- Defaults
		      enable_close = true, -- Auto close tags
		      enable_rename = true, -- Auto rename pairs of tags
		      enable_close_on_slash = false -- Auto close on trailing </
		    },
		    -- Also override individual filetype configs, these take priority.
		    -- Empty by default, useful if one of the "opts" global settings
		    -- doesn't work well in a specific filetype
		    per_filetype = {
		      ["html"] = {
			enable_close = false
		      }
		    }
		  })
	  end
	},
	{ "nvim-treesitter/nvim-treesitter",
	  build = ":TSUpdate",
	  config = function () 
		  local configs = require("nvim-treesitter.configs")
		  configs.setup({
			  auto_install = false,
			  ignore_install = {},
			  modules = {},
			  ensure_installed = {
				  "bash",
				  "c",
				  "diff",
				  "html",
				  "javascript",
				  "jsdoc",
				  "json",
				  "lua",
				  "luadoc",
				  "luap",
				  "markdown",
				  "markdown_inline",
				  "printf",
				  "python",
				  "query",
				  "regex",
				  "rust",
				  "toml",
				  "tsx",
				  "typescript",
				  "vim",
				  "vimdoc",
				  "xml",
				  "yaml",
			  },
			  sync_install = false,
			  highlight = { enable = true },
			  indent = { enable = true },
		  })
	  end
	}
}
