require("nvim-treesitter").setup({
	ensure_installed = { "cpp", "python", "c", "lua", "vim", "vimdoc", "query", "go", "markdown" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
