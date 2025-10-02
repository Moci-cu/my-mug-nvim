-- otomatis digabung oleh vim.lsp.config (Nvim 0.11+)
return {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
