return {
  {
    "echasnovski/mini.starter",
    version = false, -- wait for new release to pin it
    lazy = false, -- load immediately
    priority = 1000, -- high priority to ensure it loads early
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        -- Configuration options (optional)
        -- See https://github.com/echasnovski/mini.starter for details
        items = {
          starter.sections.recent_files(10, false),
          starter.sections.builtin_actions(),
          {
            name = 'Fzf-lua',
            action = '',
            section = 'Fzf-lua',
          },
          {
            name = '  Files',
            action = function() vim.cmd('FzfLua files') end,
            section = 'Fzf-lua',
          },
          {
            name = '  Live grep',
            action = function() vim.cmd('FzfLua live_grep') end,
            section = 'Fzf-lua',
          },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet("» ", false),
          starter.gen_hook.aligning("center", "center"),
        },
        -- Custom header (optional)
        header = [[
          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
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
          vim.keymap.set("n", "h", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>", { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>", { buffer = true, desc = "Select next item" })
          vim.keymap.set("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>", { buffer = true, desc = "Select previous item" })
          vim.keymap.set("n", "l", "<Cmd>lua MiniStarter.update_current_item('next')<CR>", { buffer = true, desc = "Select next item" })
          -- Quick fzf-lua actions
          vim.keymap.set("n", "f", function()
            require('mini.starter').close()
            vim.cmd("FzfLua files")
          end, { buffer = true, desc = "Open fzf-lua files" })
          vim.keymap.set("n", "s", function()
            require('mini.starter').close()
            vim.cmd("FzfLua live_grep")
          end, { buffer = true, desc = "Open fzf-lua live grep" })
        end,
      })
    end,
  },
}