-- Links for reference
-- https://github.com/folke/lazy.nvim

-- configuring lazy's installation path.
-- all plugins installed/managed by lazy will reside in this folder.
-- stdpath('data') defaults to ~/.local/share/nvim
-- you can check it by running: :echo stdpath('data')
-- therefore, lazypath will usually be '~/.local/share/nvim/lazy/lazy.nvim/'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- the github repo is fetched if it isn't found in the previously configured path
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- adding lazypath to vim's internal variable 'runtimepath' a.k.a 'rtp'
-- this enables finding ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- this setup function comes from ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua!
-- it pretty much loads my custom plugins folder :)
-- this is crucial, because now when running 'require("foo")',
-- "foo" gets searched in ~/.local/share/nvim/lazy/
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "carlos.plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

-- this also works and is a shortcut for the command above :)
-- require("lazy").setup('carlos.plugins')
