local M = {}

local horizontal = { win = nil, buf = nil, peer = nil, directions = { to_self = 'j', to_peer = 'k' } }
local vertical = { win = nil, buf = nil, peer = nil, directions = { to_self = 'l', to_peer = 'h' } }

local function valid_buf(entry)
  if not entry.buf or not vim.api.nvim_buf_is_valid(entry.buf) then return nil end
  if vim.bo[entry.buf].buftype ~= 'terminal' then return nil end
  return entry.buf
end

local function valid_win(entry)
  if not entry.win or not vim.api.nvim_win_is_valid(entry.win) then return nil end
  return entry.win
end

local function valid_peer(entry)
  local peer = entry.peer
  if not peer or not vim.api.nvim_win_is_valid(peer) then return nil end
  if entry.buf and vim.api.nvim_win_get_buf(peer) == entry.buf then return nil end
  return peer
end

local function remember_peer(entry, win)
  if not win or not vim.api.nvim_win_is_valid(win) then return end
  if entry.win and win == entry.win then return end
  if entry.buf and vim.api.nvim_win_get_buf(win) == entry.buf then return end
  entry.peer = win
end

local function spawn(split_cmd, size_cmd)
  vim.cmd(split_cmd)
  vim.cmd('terminal')

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)

  if size_cmd then vim.cmd(size_cmd) end
  vim.bo[buf].bufhidden = 'hide'
  vim.cmd('startinsert')

  return win, buf
end

local function open(entry, split_cmd, size_cmd)
  local prev_win = vim.api.nvim_get_current_win()
  local buf = valid_buf(entry)
  if not buf then
    entry.win, entry.buf = spawn(split_cmd, size_cmd)
  else
    vim.cmd(split_cmd)

    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    if size_cmd then vim.cmd(size_cmd) end
    vim.cmd('startinsert')

    entry.win = win
  end

  remember_peer(entry, prev_win)
end

local function close(entry)
  local win = valid_win(entry)
  if not win then
    entry.win = nil
    entry.peer = nil
    return
  end

  if #vim.api.nvim_list_wins() == 1 then
    vim.api.nvim_win_call(win, function() vim.cmd('enew') end)
  else
    pcall(vim.api.nvim_win_close, win, true)
  end

  entry.win = nil
  entry.peer = nil
end

local function focus_terminal(entry)
  local target = valid_win(entry)
  if not target then
    if entry.directions and entry.directions.to_self then pcall(vim.cmd, 'wincmd ' .. entry.directions.to_self) end
    return
  end

  local current = vim.api.nvim_get_current_win()
  if current ~= target then remember_peer(entry, current) end

  vim.api.nvim_set_current_win(target)
  vim.cmd('startinsert')
end

local function focus_peer(entry)
  vim.cmd('stopinsert')

  local target = valid_peer(entry)
  if target then
    vim.api.nvim_set_current_win(target)
    return
  end

  entry.peer = nil
  if entry.directions and entry.directions.to_peer then pcall(vim.cmd, 'wincmd ' .. entry.directions.to_peer) end
end

function M.toggle_horizontal()
  if valid_win(horizontal) then
    close(horizontal)
    return
  end

  open(horizontal, 'botright new', 'resize 14')
end

function M.toggle_vertical()
  if valid_win(vertical) then
    close(vertical)
    return
  end

  open(vertical, 'botright vnew', 'vertical resize 80')
end

local group = vim.api.nvim_create_augroup('user.terminal', { clear = true })

vim.api.nvim_create_autocmd('TermClose', {
  group = group,
  callback = function(args)
    local h_buf = horizontal.buf
    local v_buf = vertical.buf

    if args.buf == h_buf then horizontal.win, horizontal.buf, horizontal.peer = nil, nil, nil end
    if args.buf == v_buf then vertical.win, vertical.buf, vertical.peer = nil, nil, nil end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
})

function M.focus_vertical_terminal()
  focus_terminal(vertical)
end

function M.focus_vertical_file()
  focus_peer(vertical)
end

function M.focus_horizontal_terminal()
  focus_terminal(horizontal)
end

function M.focus_horizontal_file()
  focus_peer(horizontal)
end

vim.keymap.set('n', '<C-l>', M.focus_vertical_terminal, { desc = 'Focus vertical terminal', silent = true })
vim.keymap.set('n', '<C-j>', M.focus_horizontal_terminal, { desc = 'Focus horizontal terminal', silent = true })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><Cmd>lua require('config.terminal').focus_vertical_file()<CR>]], {
  desc = 'Focus file from vertical terminal',
  silent = true,
})
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><Cmd>lua require('config.terminal').focus_horizontal_file()<CR>]], {
  desc = 'Focus file from horizontal terminal',
  silent = true,
})

return M
