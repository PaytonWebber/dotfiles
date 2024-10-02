require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "ccls" },
		cpp = { "ccls" },
		python = { "isort", "black" },
		go = { "gofmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 1000,
	},
	notify_on_error = true,
})
