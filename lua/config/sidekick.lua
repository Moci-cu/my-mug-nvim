local M = {}

local function tab_key()
  return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
end

local function try_nes()
  local ok, Nes = pcall(require, "sidekick.nes")
  if not ok then
    return false
  end
  if not Nes.have() then
    return false
  end
  return Nes.jump() or Nes.apply()
end

function M.normal_tab()
  if try_nes() then
    return ""
  end
  return tab_key()
end

function M.register_blink_action()
  local ok_actions, actions = pcall(require, "blink.cmp.actions")
  if not ok_actions then
    return
  end
  actions.ai_nes = function()
    if try_nes() then
      return true
    end
  end
end

return M
