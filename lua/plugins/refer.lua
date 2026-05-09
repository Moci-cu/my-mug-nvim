return {
  "juniorsundar/refer.nvim",
  enabled = false,
  lazy = false,
  dependencies = {
    -- Tidak perlu install blink.cmp
    -- refer.nvim akan otomatis download library blink fuzzy dari GitHub
  },
  config = function()
    require("refer").setup({
      -- Gunakan blink sebagai default sorter
      default_sorter = "blink",
      available_sorters = { "blink", "native", "lua" },
      preview = {
        enabled = true,
      },
    })
  end,
  keys = {
    { "<leader>rf", "<cmd>Refer Files<cr>", desc = "Find Files" },
    { "<leader>rg", "<cmd>Refer Grep<cr>", desc = "Grep" },
    { "<leader>rs", "<cmd>Refer Selection<cr>", desc = "Search word under cursor" },
    { "<leader>rl", "<cmd>Refer Lines<cr>", desc = "Buffer Lines" },
    { "<leader>rb", "<cmd>Refer Buffers<cr>", desc = "Buffers" },
    { "<leader>ro", "<cmd>Refer OldFiles<cr>", desc = "Recent files" },
    { "<leader>rc", "<cmd>Refer Commands<cr>", desc = "Commands" },
    { "<leader>rm", "<cmd>Refer Macros<cr>", desc = "Macros" },
    -- LSP
    { "<leader>rR", "<cmd>Refer References<cr>", desc = "LSP References" },
    { "<leader>rD", "<cmd>Refer Definitions<cr>", desc = "LSP Definitions" },
    { "<leader>rI", "<cmd>Refer Implementations<cr>", desc = "LSP Implementations" },
    { "<leader>rS", "<cmd>Refer Symbols<cr>", desc = "LSP Symbols" },
  },
}
