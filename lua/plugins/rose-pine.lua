return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main",
      extend_background_behind_borders = true,
      styles = {
        transparency = true,
        bold = true,
        italic = true
      },
      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true,        -- Handle deprecated options automatically
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",
      }

    })
    vim.cmd("colorscheme rose-pine")
  end,
}
