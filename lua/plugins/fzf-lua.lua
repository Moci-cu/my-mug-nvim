return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "echasnovski/mini.icons",
        opts = {},
      },
      "phanen/fzf-lua-extra",
    },
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        defaults = {
          header = false,
        },
        files = {
          cwd_prompt = false,
          cwd_header = false,
          prompt = "Files> ",
          winopts = {
            title = " Files ",
            title_flags = false,
          },
        },
        winopts = {
          backdrop = 100,
          fullscreen = true,
          winblend = true,
          preview = { layout = "vertical", vertical = "down:50%" },
        },
        hls = { normal = "Normal", border = "FloatBorder" },
        astgrep = { debug = false },
        keymap = {
          builtin = {
            ["<S-Up>"] = "",
            ["<S-down>"] = "",
          },
          fzf = {
            ["ctrl-h"] = "backward-kill-word",
            ["shift-down"] = "half-page-down",
            ["shift-up"] = "half-page-up",
            ["home"] = "first",
            ["end"] = "last",
            ["ctrl-q"] = "select-all+accept",
          },
        },
        actions = {
          files = {
            true,
            ["alt-i"] = fzf.actions.toggle_ignore,
            ["enter"] = nil,
            ["ctrl-s"] = nil,
            ["ctrl-v"] = nil,
            ["ctrl-t"] = nil,
            ["alt-q"] = nil,
            ["alt-Q"] = nil,
            ["alt-h"] = nil,
            ["alt-f"] = nil,
          },
        },
      })

      local rules = {
        Golang = {
          Function = [[^func +(?:\([a-zA-Z0-9_]+ +\*?[a-zA-Z0-9_]+(?:\[.+\])?\))? *[A-Z][a-zA-Z0-9_]* -- !*test* ]],
          Type = [[^type +[A-Z][a-zA-Z0-9_]+ -- !*test* ]],
        },
        Rust = {
          Function_and_Macro = [[(^\s*pub (const )?(unsafe )?fn +[a-zA-Z0-9_#]+|^\s*macro_rules! [a-zA-Z0-9_#]+|^impl )]],
          Type = [[^\s*pub (?:struct|union|enum|trait|type) [a-zA-Z0-9_#]+]],
        },
        C = {
          Function = [[^[a-zA-Z_*][a-zA-Z0-9_* ]*\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\(.*\)]],
          Struct = [[^struct\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\{]],
          Typedef = [[^typedef\s+]],
          Enum = [[^enum\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\{]],
          Union = [[^union\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\{]],
        },
      }

      local lang_options = {
        Golang = { "Function", "Type", "Stdlib", "Files", "Any" },
        Rust = { "Function_and_Macro", "Type", "Files", "Any" },
        C = { "Function", "Struct", "Typedef", "Enum", "Union", "Stdlib", "Files", "Any" },
      }

      local function module_api_search()
        local detected = nil
        local ft = vim.bo.filetype
        if ft == "go" then
          detected = "Golang"
        elseif ft == "rust" then
          detected = "Rust"
        elseif ft == "c" then
          detected = "C"
        end

        if not detected then
          fzf.fzf_exec({ "Files", "Any" }, {
            prompt = "Search > ",
            actions = {
              ["default"] = function(selected)
                if not selected or #selected == 0 then return end
                local choice = selected[1]
                if choice == "Any" then
                  fzf.live_grep()
                elseif choice == "Files" then
                  fzf.files()
                end
              end,
            },
          })
          return
        end

        local items = lang_options[detected]
        fzf.fzf_exec(items, {
          prompt = string.format("Search (%s) > ", detected),
          actions = {
            ["default"] = function(selected)
              if not selected or #selected == 0 then return end
              local choice = selected[1]
              if choice == "Any" then
                fzf.live_grep()
              elseif choice == "Files" then
                fzf.files()
              elseif choice == "Stdlib" then
                local cwd
                if detected == "Golang" then
                  local goroot = vim.fn.system("go env GOROOT"):gsub("%s+", "")
                  cwd = goroot .. "/src"
                elseif detected == "C" then
                  cwd = "/usr/include"
                end
                if cwd then fzf.files({ cwd = cwd }) end
              else
                fzf.grep({
                  search = rules[detected][choice],
                  no_esc = true,
                  silent = true,
                })
              end
            end,
          },
        })
      end

      vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Files" })
      vim.keymap.set("n", "<C-g>", function() fzf.grep({ fuzzy = true }) end, { desc = "Grep" })
      vim.keymap.set("n", "<C-l>", function() fzf.grep({ fuzzy = true, search = "" }) end, { desc = "Live grep" })
      vim.keymap.set("n", "<C-b>", fzf.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<C-k>", fzf.builtin, { desc = "Builtin" })
      vim.keymap.set("n", "<F1>", fzf.helptags, { desc = "Help" })
      vim.keymap.set("n", "<leader>s", module_api_search, { desc = "Module API search" })
    end,
  },
}
