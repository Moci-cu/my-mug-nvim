local icons = {
  Error = "",
  Warn = "",
  Info = "",
  Hint = "",
}

for severity, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. severity
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  underline = true,
  severity_sort = true,
  update_in_insert = true,
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code)
      if code then return string.format("%s [%s]", d.message, code) end
      return d.message
    end,
  },
})
