return {
  {
    "echasnovski/mini.starter",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      local starter = require("mini.starter")
      local fzf = require("fzf-lua")

      local open_picker = function(picker)
        return function()
          starter.close()
          picker()
        end
      end

      starter.setup({
        items = {
          starter.sections.builtin_actions(),
          {
            name = "f - Files",
            action = open_picker(function() fzf.files() end),
            section = "",
          },
          {
            name = "r - Grep",
            action = open_picker(function() fzf.live_grep() end),
            section = "",
          },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet("» ", false),
          starter.gen_hook.aligning("center", "center"),
        },
        footer = "",
        evaluate_single = true,
        query_updaters = 'abcdeimnopqrtuvwxyz0123456789_-.',
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          vim.keymap.set("n", "<Leader>q", "<Cmd>qa<CR>", { buffer = true, desc = "Quit Neovim" })
          vim.keymap.set("n", "h", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>",
            { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>",
            { buffer = true, desc = "Select next item" })
          vim.keymap.set("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>",
            { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "l", "<Cmd>lua MiniStarter.update_current_item('next')<CR>",
            { buffer = true, desc = "Select next item" })
          vim.keymap.set("n", "f", open_picker(function() fzf.files() end), { buffer = true, desc = "Files" })
          vim.keymap.set("n", "r", open_picker(function() fzf.live_grep() end), { buffer = true, desc = "Grep" })
        end,
      })
    end,
  },
}
