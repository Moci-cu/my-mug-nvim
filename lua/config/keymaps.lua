local map, opts = vim.keymap.set, { silent = true }
local terminal = require('config.terminal')

local function clear_search_then_escape()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohlsearch()
  end
  return vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
end

map({ 'n', 'v' }, '<Esc>', clear_search_then_escape, { expr = true, desc = 'Escape and clear search' })
map({ 'n', 'v' }, '<C-c>', clear_search_then_escape, { expr = true, desc = 'Escape and clear search' })

map('n', '<leader>f', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>rg', '<cmd>Telescope live_grep<cr>', opts)

map('n', '<leader>ht', terminal.toggle_horizontal, { silent = true, nowait = true, desc = 'Toggle terminal' })
map('n', '<leader>ts', terminal.toggle_vertical, { silent = true, nowait = true, desc = 'Toggle vertical terminal' })

map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
