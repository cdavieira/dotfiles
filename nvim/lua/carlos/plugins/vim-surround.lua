-- https://github.com/tpope/vim-surround
-- https://github.com/tpope/vim-repeat
-- https://github.com/windwp/nvim-autopairs

return {
	{ 'tpope/vim-surround' },
	-- { 'tpope/vim-repeat' },
	{
	    'windwp/nvim-autopairs',
	    event = "InsertEnter",
	    config = true
	    -- use opts = {} for passing setup options
	    -- this is equivalent to setup({}) function
	}
}
