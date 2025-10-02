return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local function lsp_status()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      local names = {}
      for _, client in ipairs(clients) do
        if client.name ~= "" and client.name ~= "null-ls" then
          table.insert(names, client.name)
        end
      end
      if vim.tbl_isempty(names) then
        return ""
      end
      return table.concat(names, ",")
    end

    local function lsp_icon()
      if next(vim.lsp.get_clients({ bufnr = 0 })) == nil then
        return ""
      end
      return ""
    end

    local function git_icon()
      if vim.b.gitsigns_head and vim.b.gitsigns_head ~= "" then
        return ""
      end
      local ok, head = pcall(function()
        return vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
      end)
      if ok and head ~= nil and head ~= "" then
        return ""
      end
      return ""
    end

    local theme = vim.deepcopy(require("lualine.themes.auto"))
    for _, mode in pairs(theme) do
      if mode.b then mode.b.bg = "None" end
      if mode.c then mode.c.bg = "None" end
    end

    return {
      options = {
        theme = theme,
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = {
          {
            function()
              return ""
            end,
            padding = { left = 0, right = 1 },
          },
          git_icon,
          lsp_icon,
        },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = "", readonly = "", unnamed = "󰡯" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            update_in_insert = true,
          },
          { lsp_status, color = { gui = "bold" } },
          { "filetype", icon_only = false, separator = "" },
        },
        lualine_y = {
          { "progress", separator = "" },
        },
        lualine_z = {
          { "location" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy", "man", "quickfix" },
    }
  end,
}
