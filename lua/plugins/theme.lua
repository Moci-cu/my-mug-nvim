return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd("colorscheme solarized-osaka")
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.NvimTreeNormal = { bg = "none" }
        hl.NvimTreeNormalNC = { bg = "none" }
        hl.NvimTreeEndOfBuffer = { bg = "none" }
      end,
    },
  }
}
