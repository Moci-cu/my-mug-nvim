local M = {}

local default_kind_icons = {
  Text = "󰉿 ",
  Method = "󰆧 ",
  Function = "󰡱 ",
  Constructor = " ",
  Field = "󰜢 ",
  Variable = "󰀫 ",
  Class = "󰠱 ",
  Interface = " ",
  Module = " ",
  Property = "󰜢 ",
  Unit = " ",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = "󰌋 ",
  Snippet = " ",
  Color = "󰏘 ",
  File = "󰈙 ",
  Reference = "󰈇 ",
  Folder = "󰉋 ",
  EnumMember = " ",
  Constant = "󰏿 ",
  Struct = "󰙅 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰬛 ",
}

local ok_icons, nvchad_icons = pcall(require, "nvchad.icons")
if ok_icons and nvchad_icons.kind then
  default_kind_icons = vim.tbl_extend("force", default_kind_icons, nvchad_icons.kind)
end

M.icons = {
  kind = default_kind_icons,
}

local function get_hl(name)
  local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok then
    return {}
  end
  return value
end

function M.apply_float_style()
  local float = get_hl("NormalFloat")
  float.bg = "NONE"
  vim.api.nvim_set_hl(0, "NormalFloat", float)

  local border = get_hl("FloatBorder")
  border.bg = "NONE"
  vim.api.nvim_set_hl(0, "FloatBorder", border)

  -- Keep completion popups aligned with our float styling.
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelected", { link = "PmenuSel" })
  vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "BlinkCmpSignature", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "BlinkCmpSignatureBorder", { link = "FloatBorder" })

  -- Telescope mirrors NvChad-style float styling too.
  vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "Title" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "NormalFloat" })
end

M.apply_float_style()

vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Reapply transparent float styling",
  callback = M.apply_float_style,
})

return M
