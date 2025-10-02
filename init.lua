-- ~/.config/nvim/init.lua
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- ~/.config/nvim/init.lua
require("config.keymaps")
require("config.lazy") -- bootstrap & load plugins/
require("config.options")
require("config.autocmds")
require("config.ui")
require("config.diagnostic")
