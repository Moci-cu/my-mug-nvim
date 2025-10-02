return {
  'datsfilipe/vesper.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('vesper').setup({
      transparent = true,
      disable_background = true,
    })
    vim.cmd.colorscheme('vesper')
  end,
}
