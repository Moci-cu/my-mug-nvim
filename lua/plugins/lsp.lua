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
      -- Completion options for built-in LSP completion
      vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert" }
      vim.opt.pumborder = "rounded"

      -- Completion keymaps
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { desc = 'Trigger LSP completion' })

      vim.keymap.set('i', '<CR>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-y>'
        end
        return '<CR>'
      end, { expr = true, desc = 'Accept completion or newline' })

      vim.keymap.set('i', '<C-j>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-n>'
        end
        return '<C-j>'
      end, { expr = true, desc = 'Next completion item or newline' })

      vim.keymap.set('i', '<C-k>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-p>'
        end
        return '<C-k>'
      end, { expr = true, desc = 'Prev completion item or delete line' })

      -- 1. Define the on_attach function. This is the heart of the LSP experience.
      -- It runs whenever a server attaches to a buffer.
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          if desc and desc ~= "" then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        -- All LSP keymaps, buffer-local (only active when LSP is attached)
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("gr", vim.lsp.buf.references, "References")
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
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Enable built-in LSP completion with autotrigger (per docs)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp.completion', { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then return end
          if not client:supports_method('textDocument/completion') then return end

          -- Extend triggerCharacters for autotrigger on every keypress
          local chars = {}
          for i = 32, 126 do
            table.insert(chars, string.char(i))
          end
          client.server_capabilities.completionProvider.triggerCharacters = chars

          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end,
      })

      local servers = { "lua_ls", "clangd", "marksman", "rust_analyzer", "zls" }
      for _, server in ipairs(servers) do
        local ok, server_opts = pcall(require, "lsp." .. server)
        if ok then
          vim.lsp.config(server, server_opts)
        end
      end

      -- 3. Let mason-lspconfig handle the installation and enabling of servers.
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
