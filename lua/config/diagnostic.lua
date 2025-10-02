vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		source = "always",
	},
  signs = false,
	underline = true,
	severity_sort = true,
	update_in_insert = true,
	float = {
		border = "rounded",
		source = "always",
		focusable = false,
		format = function(d)
			local code = d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code)
			if code then return string.format("%s [%s]", d.message, code) end
			return d.message
		end,
	},
})
