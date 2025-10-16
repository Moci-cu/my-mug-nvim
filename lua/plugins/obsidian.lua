return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = function()
    local vault_path = vim.fs.normalize(vim.fn.expand("~/motitu/zeze/"))

    return {
      workspaces = {
        {
          name = "personal",
          path = vault_path,
        },
      },
      completion = {
        nvim_cmp = true,
      },
      ui = {
        enable = true,
      },
    }
  end,
  config = function(_, opts)
    require("obsidian").setup(opts)

    local group = vim.api.nvim_create_augroup("ObsidianConcealFix", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "markdown", "quarto" },
      callback = function()
        if vim.opt_local.conceallevel:get() < 1 then
          vim.opt_local.conceallevel = 2
        end
      end,
    })
  end,
}
