return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
  -- HANYA jika muncul warning offset_encodings, aktifkan baris di bawah:
  -- capabilities = (function()
  --   local c = vim.lsp.protocol.make_client_capabilities()
  --   c.offsetEncoding = { "utf-16" }
  --   return c
  -- end)(),
}

