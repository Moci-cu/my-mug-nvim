return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "noselect" }
    vim.opt.pumborder = "rounded"

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "gl", vim.diagnostic.open_float, "Line Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

        map("i", "<C-Space>", function()
          vim.lsp.completion.get()
        end, "Trigger completion")

        vim.keymap.set("i", "<CR>", function()
          if vim.fn.pumvisible() == 1 then
            return vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
          end
          return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        end, { buffer = bufnr, expr = true, desc = "LSP: Accept completion or newline" })

        vim.diagnostic.reset()

        if client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = false,
          })
        end

        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    local servers = { "lua_ls", "clangd", "marksman", "rust_analyzer", "zls" }
    for _, server in ipairs(servers) do
      local ok, server_opts = pcall(require, "lsp." .. server)
      if ok then
        vim.lsp.config(server, server_opts)
      end
    end

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      handlers = {
        function(server)
          vim.lsp.enable(server)
        end,
      },
    })
  end,
}
