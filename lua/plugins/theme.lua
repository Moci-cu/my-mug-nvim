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
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#3d3d3d" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#0cd0f9", bold = true })
    end,
  },
}
