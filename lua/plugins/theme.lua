return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italics = {
        comments = true,
        keywords = true,
        functions = false,
        strings = false,
        variables = false,
      },
      overrides = {},
      palette_overrides = {}
    },
    config = function()
      require("eldritch").setup({
        transparent = true,
        italics = {
          comments = true,
          keywords = true,
          functions = false,
          strings = false,
          variables = false,
        },
        overrides = {},
        palette_overrides = {}
      })
      vim.cmd.colorscheme("eldritch")
    end,
  },
}
