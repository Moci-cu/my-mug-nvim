return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      require("dap.ext.vscode").load_launchjs(nil, {
        codelldb = { "c", "cpp", "rust" },
      })
    end,
    dependencies = {
      -- UI for nvim-dap
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)

          -- Otomatis buka/tutup DAP UI saat session mulai/selesai
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      {
        "stevearc/overseer.nvim",
        opts = {},
      },
      -- Install debug adapters via Mason
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
          ensure_installed = { "codelldb" },
          handlers = {},
        },
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Toggle DAP UI" },
    },
  },
}
