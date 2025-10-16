return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  opts = function()
    local ui = require("config.ui")
    return {
      enabled = function()
        if vim.bo.buftype == 'prompt' then
          return true
        end
        return vim.bo.filetype ~= 'markdown'
      end,
      keymap = {
        preset = "super-tab",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-d>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<C-j>"] = {
          "select_next",
          "fallback_to_mappings",
        },
        ["<C-k>"] = {
          "select_prev",
          "fallback_to_mappings",
        },
        ["<Tab>"] = {
          function()
            local ok_actions, actions = pcall(require, "blink.cmp.actions")
            if ok_actions and actions.ai_nes and actions.ai_nes() then
              return true
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "snippet_backward",
          "fallback",
        },
      },
      appearance = {
        use_nvim_cmp_style = true,
        kind_icons = ui.icons.kind,
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 120,
        },
        menu = {
          border = "rounded",
        },
      },
      signature = {
        enabled = true,
        auto_open = true,
        border = "rounded",
      },
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
      },
    }
  end,
  config = function(_, opts)
    local blink = require("blink.cmp")
    blink.setup(opts)

    require("config.sidekick").register_blink_action()

    local ok_loader, loader = pcall(require, "luasnip.loaders.from_vscode")
    if ok_loader then
      loader.lazy_load()
    end
  end,
}
