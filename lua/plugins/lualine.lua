return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local function lsp_icon()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.name ~= "" and client.name ~= "null-ls" then
          return "󰒋"
        end
      end
      return ""
    end

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "󰊢" },
          { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
        },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", lsp_icon, "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy", "man" },
    }
  end,
}
