return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
  },
}