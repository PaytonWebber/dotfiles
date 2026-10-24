require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "isort", "black" },
		go = { "gofmt" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 1000,
	},
	notify_on_error = true,
})
