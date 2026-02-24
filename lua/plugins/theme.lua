return {
  {
    "Everblush/nvim",
    name = "everblush",
    lazy = false,
    priority = 1000,
    config = function()
      require("everblush").setup({
        transparent_background = false,
        nvim_tree = {
          contrast = false,
        },
      })
      vim.cmd("colorscheme everblush")
    end,
  }
}
