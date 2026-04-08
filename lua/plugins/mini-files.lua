return {
  "echasnovski/mini.files",
  version = false,
  dependencies = {
    "echasnovski/mini.icons",
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open()
      end,
      desc = "Open mini.files",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)
    local close = function() require("mini.files").close() end
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "<Esc>", close, { buffer = buf_id })
        vim.keymap.set("n", "<CR>", function()
          require("mini.files").go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = "Go in and close" })
      end,
    })
  end,
  opts = {
    windows = {
      preview = true,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 50,
    },
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "L",
      go_out = "h",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = "<BS>",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },
  },
}
