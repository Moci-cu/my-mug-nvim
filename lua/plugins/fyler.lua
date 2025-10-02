return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	branch = "stable",
	---@module 'fyler'
	---@type FylerSetupOptions
	keys = {
		{ "<leader>e", function() require("fyler").open() end, desc = "Fyler" },
	},
	opts = {}
}
