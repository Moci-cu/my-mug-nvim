local aug = vim.api.nvim_create_augroup("user.autocmds", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function() vim.highlight.on_yank() end,
})

-- Prevent flickering when saving in hypr config directory
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   pattern = { "*/.config/hypr/*" },
--   callback = function()
--     vim.opt_local.swapfile = false
--     vim.opt_local.backup = false
--     vim.opt_local.writebackup = false
--     vim.opt_local.backupcopy = "yes"
--   end,
-- })
