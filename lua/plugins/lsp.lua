return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      -- 1. Define the on_attach function. This is the heart of the LSP experience.
      -- It runs whenever a server attaches to a buffer.
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          if desc and desc ~= "" then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        -- All our keymaps, which will now be buffer-local
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("gl", vim.diagnostic.open_float, "Line Diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic")

        -- Force a diagnostic refresh on attach, as a final measure
        vim.diagnostic.reset()

        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          if vim.lsp.inlay_hint.enable then
            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
          elseif vim.lsp.inlay_hint.set then
            pcall(vim.lsp.inlay_hint.set, bufnr, true)
          end
        end
      end

      -- 2. Configure lspconfig to use our on_attach function for all servers.
      -- We use the "*" wildcard to apply this to every server.
      -- This uses the new, non-deprecated API.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      do
        local ok_blink, blink_cmp = pcall(require, "blink.cmp")
        if ok_blink then
          if blink_cmp.get_lsp_capabilities then
            capabilities = blink_cmp.get_lsp_capabilities(capabilities)
          elseif blink_cmp.get_capabilities then
            capabilities = blink_cmp.get_capabilities(capabilities)
          end
        end
      end

      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      local servers = { "lua_ls", "clangd", "marksman", "rust_analyzer", "zls" }
      for _, server in ipairs(servers) do
        local ok, server_opts = pcall(require, "lsp." .. server)
        if ok then
          vim.lsp.config(server, server_opts)
        end
      end

      -- 3. Let mason-lspconfig handle the installation and enabling of servers.
      -- It will automatically pick up the default configuration we just set.
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        handlers = {
          function(server)
            if vim.lsp.enable then
              vim.lsp.enable(server)
              return
            end

            local ok_cfg, lspconfig = pcall(require, "lspconfig")
            if ok_cfg and lspconfig[server] then
              lspconfig[server].setup({})
            end
          end,
        },
      })
    end,
  },
}
