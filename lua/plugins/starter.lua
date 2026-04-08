return {
  {
    "echasnovski/mini.starter",
    version = false, -- wait for new release to pin it
    lazy = false,    -- load immediately
    priority = 1000, -- high priority to ensure it loads early
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        -- Configuration options (optional)
        -- See https://github.com/echasnovski/mini.starter for details
        items = {
          starter.sections.builtin_actions(),
          {
            name = 'Mini.Pick',
            action = '',
            section = 'Mini.Pick',
          },
          {
            name = '  Files',
            action = function() require('mini.starter').close(); require('mini.pick').builtin.files() end,
            section = 'Mini.Pick',
          },
          {
            name = '  Live grep',
            action = function() require('mini.starter').close(); require('mini.pick').builtin.grep() end,
            section = 'Mini.Pick',
          },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet("» ", false),
          starter.gen_hook.aligning("center", "center"),
        },
        -- Custom header (optional)
        -- header = [[
        --   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        --   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        --   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        --   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        --   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        --   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        -- ]],
        -- Footer (optional)
        footer = "",
        -- Evaluate this function to get footer dynamically
        evaluate_single = true,
        -- Remove h,j,k,l,f,g,s from query updaters to use them for navigation
        query_updaters = 'abcdeimnopqrtuvwxyz0123456789_-.',
      })

      -- Auto-open starter when Neovim starts with no file arguments
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          -- Optional: set some keymaps for the starter buffer
          vim.keymap.set("n", "<Leader>q", "<Cmd>qa<CR>", { buffer = true, desc = "Quit Neovim" })
          -- Vim-style navigation (h/j/k/l for movement)
          vim.keymap.set("n", "h", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>",
            { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>",
            { buffer = true, desc = "Select next item" })
          vim.keymap.set("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>",
            { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "l", "<Cmd>lua MiniStarter.update_current_item('next')<CR>",
            { buffer = true, desc = "Select next item" })
          -- Quick pick actions
          vim.keymap.set("n", "f", function()
            require('mini.starter').close()
            require('mini.pick').builtin.files()
          end, { buffer = true, desc = "Open pick files" })
          vim.keymap.set("n", "s", function()
            require('mini.starter').close()
            require('mini.pick').builtin.grep()
          end, { buffer = true, desc = "Open pick grep" })
        end,
      })
    end,
  },
}
