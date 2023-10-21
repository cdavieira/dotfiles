--[[
	https://github.com/folke/lazy.nvim
	https://www.youtube.com/watch?v=6mxWayq-s9I
--]]

-- :echo stdpath('config') -> /home/carlos/.config/nvim
-- :echo stdpath('data') -> /home/carlos/.local/share/nvim

-- configuring lazy's installation path
-- all eventually installed plugins will reside in this folder
-- stdpath('data') defaults to ~/.local/share/nvim
-- you can check it by running: :echo stdpath('data')
-- so lazy's path will usually be '~/.config/share/nvim/lazy/lazy.nvim/'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- the github repo is fetched if isn't found in the previously configured path
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- lazy's path gets added to vim's 'runtimepath'/'rtp' variable
-- theoretically, this enables finding ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua
vim.opt.rtp:prepend(lazypath)


-- this setup function comes from ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua!
-- it pretty much loads my custom plugins folder :)
-- this is crucial, because now when running 'require("foo")',
-- "foo" gets searched in ~/.local/share/nvim/lazy/
require("lazy").setup('carlos.plugins')
