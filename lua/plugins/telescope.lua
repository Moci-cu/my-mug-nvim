return {
  "nvim-telescope/telescope.nvim",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    return {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
          width = 0.88,
          height = 0.84,
          horizontal = {
            preview_width = 0.58,
          },
          vertical = {
            preview_cutoff = 20,
          },
        },
        winblend = 0,
        borderchars = {
          prompt = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          results = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          preview = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        results_title = false,
        dynamic_preview_title = true,
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-n>"] = false,
            ["<C-p>"] = false,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
        },
        live_grep = {
          theme = "dropdown",
          previewer = true,
          prompt_prefix = "   ",
          prompt_title = " ripgrep ",
          sorting_strategy = "ascending",
          layout_config = {
            width = 0.6,
            height = 0.46,
            preview_cutoff = 25,
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- load extensions lazily when available
    pcall(telescope.load_extension, "fzf")
  end,
}
