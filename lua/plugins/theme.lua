return {
  {
    "luisiacc/gruvbox-baby",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.g.gruvbox_baby_background_color = "darker"
      vim.cmd.colorscheme("gruvbox-baby")

      -- Force some highlights if the theme doesn't handle them perfectly
      local highlights = {
        ["Normal"] = { bg = "none" },
        ["NormalFloat"] = { bg = "none" },
        ["NormalNC"] = { bg = "none" },
        ["FloatBorder"] = { bg = "none" },
        ["SignColumn"] = { bg = "none" },
        ["LineNr"] = { fg = "#504945", bg = "none" },
        ["CursorLineNr"] = { fg = "#fabd2f", bold = true, bg = "none" },
        ["EndOfBuffer"] = { bg = "none" },
        ["NeoTreeNormal"] = { bg = "none" },
        ["NeoTreeNormalNC"] = { bg = "none" },
      }

      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end,
  },
}
