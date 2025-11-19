return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  keys = {
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.toggle({ focus = true })
      end,
      desc = "Toggle file explorer",
    },
  },
  opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      width = 32,
    },
    renderer = {
      group_empty = true,
      indent_markers = { enable = true },
    },
    filters = {
      dotfiles = false,
      git_ignored = true,
    },
    actions = {
      open_file = { quit_on_open = true },
    },
  },
}
