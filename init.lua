-- ~/.config/nvim/init.lua
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true


-- ~/.config/nvim/init.lua
require("config.keymaps")
require("config.lazy") -- bootstrap & load plugins/
require("config.options")
require("config.autocmds")
require("config.ui")
require("config.diagnostic")
