return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("diffview").setup(opts)
    vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "Open Diffview" })
    vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { silent = true, desc = "Close Diffview" })
    vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", { silent = true, desc = "File History" })
  end,
}