return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = function()
    -- ensure our custom Blink action is registered even if Blink loads first
    local helpers = require("config.sidekick")
    helpers.register_blink_action()
    return {}
  end,
  config = function(_, opts)
    require("sidekick").setup(opts)
    require("config.sidekick").register_blink_action()
  end,
  keys = {
    {
      "<Tab>",
      function()
        return require("config.sidekick").normal_tab()
      end,
      mode = { "n" },
      expr = true,
      silent = true,
      desc = "Sidekick Apply Nes",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      mode = { "n" },
      desc = "Sidekick Select CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").send()
      end,
      mode = { "v" },
      desc = "Sidekick Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "v" },
      desc = "Sidekick Prompt",
    },
    {
      "<C-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Focus",
    },
  },
}
