-- changing the leader key to space
vim.g.mapleader = " "


-- loading my modules
local mylazyness = require("carlos.lazy")
local telescope = require('telescope.builtin')
local neotree = require('neo-tree.command')
local lspconfig = require('lspconfig')


-- colorschemes
vim.cmd.colorscheme "catppuccin"


-- vim variables
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2


-- Global mappings.
vim.keymap.set('n', '<leader>f', telescope.find_files, {})
vim.keymap.set('n', '<leader>s', telescope.live_grep, {})
vim.keymap.set('n', '<leader>b', telescope.buffers, {})
vim.keymap.set('n', '<leader>h', telescope.help_tags, {})
vim.keymap.set('n', '<leader>m', telescope.man_pages, {})
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')
vim.keymap.set('n', '<leader>c', '<Cmd>edit /home/carlos/.config/nvim/ <CR>')
-- See `:help vim.diagnostic.*` for more
vim.keymap.set('n', '<space>g', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


-- copied from https://github.com/neovim/nvim-lspconfig
-- Setup language servers.
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.rust_analyzer.setup {
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		['rust-analyzer'] = {},
	},
}


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>H', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})


-- :h 'runtimepath'
-- :h mapleader
-- :h lua.txt
-- :h lua-loop
-- :h lsp
-- :h lsp-config
-- :h lsp-events
-- :h vim.lsp.start()
-- to view the contents of a table
-- 	:lua =vim.lsp
-- find where lsp log files are:
-- 	:lua print(vim.lsp.get_log_path())
-- 	:lua print(vim.inspect(vim.loop))
