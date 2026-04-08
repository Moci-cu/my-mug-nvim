return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
  -- capabilities = (function()
  --   local c = vim.lsp.protocol.make_client_capabilities()
  --   c.offsetEncoding = { "utf-16" }
  --   return c
  -- end)(),
}
