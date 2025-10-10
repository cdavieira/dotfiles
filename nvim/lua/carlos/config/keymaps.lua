Telescope = require('telescope.builtin')
Neotree = require('neo-tree.command')
Toggleterm = require('toggleterm')



---@enum special_keys
local SPECIAL_KEYS = {
	Leader = '<leader>',
	Shift = '<S-#>',
}

---@enum vim_modes
local VIM_MODES = {
	Normal = 'n'
}



---Build a string using the Leader special key
---@param key string
---@return string
local BuildLeaderShortcut = function (key)
	local shortcut = SPECIAL_KEYS.Leader .. key
	return shortcut
end

---Add shortcuts which use leader as prefix
---@param keys string
---@param callback function|string
---@param description string
local AddNormalLeaderKeymap = function (keys, callback, description)
	local mode = VIM_MODES.Normal
	local cmd = BuildLeaderShortcut(keys)
	vim.keymap.set(mode, cmd, callback, {desc = description})
end




local telescope_search_all_manpages = function()
	Telescope.man_pages({sections = {'ALL'}})
end

local neotree_edit_myfolder = function()
	local xdg_config_path = os.getenv('XDG_CONFIG_HOME')
	local my_config_path = xdg_config_path .. '/nvim/lua/carlos'
	Neotree.execute({
		dir = my_config_path,
		toggle = true,
	})
end

local neotree_toggle = function()
	Neotree.execute({
		toggle = true
	})
end




AddNormalLeaderKeymap('f', Telescope.find_files, 'Perform filename search in cwd')
AddNormalLeaderKeymap('s', Telescope.live_grep, 'Perform string search in cwd')
AddNormalLeaderKeymap('b', Telescope.buffers, 'Perform filename search in neovim\'s buffer list')
AddNormalLeaderKeymap('n', Telescope.help_tags, 'Search for help within neovim help tags')
AddNormalLeaderKeymap('m', telescope_search_all_manpages, 'Search for a manpage')
AddNormalLeaderKeymap('e', neotree_toggle, 'Toggle Neotree side panel')
AddNormalLeaderKeymap('p', neotree_edit_myfolder, 'Edit Lazy\'s plugins file' )

vim.keymap.set('n', '\\', Toggleterm.toggle, {desc = 'Edit Lazy\'s plugins file'})
vim.keymap.set('t', '\\', Toggleterm.toggle, {desc = 'Edit Lazy\'s plugins file'})

AddNormalLeaderKeymap('g', vim.diagnostic.open_float, 'Open diagnosis floating panel')
AddNormalLeaderKeymap('i', '<Cmd>edit /home/carlos/.config/nvim/init.lua <CR>', 'Edit init.lua')
AddNormalLeaderKeymap('y', '"+y', 'Copy to system clipboard')

vim.keymap.set('n', '<S-Esc>', ':noh<CR>', {desc = 'Unhighlight previous search highlight'})

-- Example gaaip to align a paragraph to 1 character
vim.keymap.set(
    'x',
    'gac',
    function()
        local a = require'align'
        a.operator(a.align_to_char)
    end,
    { noremap = true, silent = true }
)

vim.keymap.set(
    'x',
    'gas',
    function()
        local a = require'align'
        a.operator(a.align_to_string)
    end,
    { noremap = true, silent = true }
)
-- vim.keymap.set(
-- 	{ 'n' },
-- 	'<C-k>',
-- 	function()
-- 		require('lsp_signature').toggle_float_win()
-- 	end,
-- 	{
-- 		silent = true,
-- 		noremap = true,
-- 		desc = 'toggle signature'
-- 	}
-- )
-- vim.keymap.set(
-- 	{ 'n' },
-- 	'<Leader>k',
-- 	function()
-- 		vim.lsp.buf.signature_help()
-- 	end,
-- 	{
-- 		silent = true,
-- 		noremap = true,
-- 		desc = 'toggle signature'
-- 	}
-- )

