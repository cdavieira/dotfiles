--[[
	:h 'runtimepath'
	:h mapleader
--]]

--[[
	[X] change mapleader key
		https://www.reddit.com/r/neovim/comments/p6dhrk/set_space_to_leader_key_with_lua/
	[ ] something else
--]]

vim.g.mapleader = " "
local mylazyness = require("carlos.lazy")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.cmd.colorscheme "catppuccin"
