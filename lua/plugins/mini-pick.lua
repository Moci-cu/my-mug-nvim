return {
  "echasnovski/mini.pick",
  version = false,
  dependencies = {
    "echasnovski/mini.icons",
  },
  keys = {
    {
      "<leader><leader>",
      function()
        require("mini.pick").builtin.grep_live()
      end,
      desc = "Grep search",
    },
  },
  opts = {
    mappings = {
      -- choose = "<CR>",
      choose_in_split = "<C-s>",
      choose_in_vsplit = "<C-v>",
      choose_in_tabpage = "<C-t>",
      choose_marked = "<M-CR>",
      move_down = "<C-j>",
      move_up = "<C-k>",
      mark = "<C-x>",
      mark_all = "<C-a>",
      toggle_preview = "<Tab>",
      toggle_info = "<S-Tab>",
      stop = "<Esc>",
    },
  },
}
