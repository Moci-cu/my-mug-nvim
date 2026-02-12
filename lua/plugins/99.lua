return {
  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require("99")

      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)

      _99.setup({
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },

        completion = {
          custom_rules = {
            "scratch/custom_rules/",
          },

          files = {
            enabled = true,
            max_file_size = 102400,
            max_files = 5000,
            exclude = { ".env", ".env.*", "node_modules", ".git" },
          },

          source = "cmp",
        },

        md_files = {
          "AGENT.md",
        },

        provider = _99.OpenCodeProvider,
        model = "deepseek/deepseek-chat",
        -- model = "qwen/qwen3-next"
      })

      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end, { desc = "99 visual selection" })

      vim.keymap.set("n", "<leader>9s", function()
        _99.stop_all_requests()
      end, { desc = "99 stop all requests" })

      vim.keymap.set("n", "<leader>9l", function()
        _99.view_logs()
      end, { desc = "99 view logs" })
    end,
  }
}
