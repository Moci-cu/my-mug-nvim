return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    "default-title",
    winopts = {
      width = 0.88,
      height = 0.84,
      row = 0.35,
      col = 0.50,
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      preview = {
        horizontal = "right:58%",
        vertical = "down:45%",
        layout = "flex",
        flip_columns = 120,
        delay = 60,
        title_pos = "center",
      },
    },
    fzf_colors = true,
    fzf_opts = {
      ["--layout"] = "reverse",
      ["--info"] = "inline-right",
    },
    keymap = {
      builtin = {
        true,
        ["<C-j>"] = "down",
        ["<C-k>"] = "up",
      },
      fzf = {
        true,
        ["ctrl-q"] = "select-all+accept",
      },
    },
    files = {
      prompt = "   ",
      cwd_prompt = false,
      fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules]],
      winopts = {
        width = 1.00,
        height = 0.40,
        row = 1.00,
        col = 0.00,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        preview = {
          hidden = "nohidden",
          horizontal = "right:50%",
          layout = "horizontal",
        },
      },
    },
    grep = {
      prompt = "   ",
      winopts = {
        width = 1.00,
        height = 0.40,
        row = 1.00,
        col = 0.00,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        preview = {
          hidden = "nohidden",
          horizontal = "right:50%",
          layout = "horizontal",
        },
      },
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    require("fzf-lua").register_ui_select()
  end,
}
