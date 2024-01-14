local themes = require("telescope.themes")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		cycle_layout_list = { "horizontal", "vertical" },
		layout_config = {
			vertical = {
				preview_height = 0.5,
			},
			flex = {
				flip_columns = 160,
			},
			horizontal = {
				preview_width = 0.5,
			},
			height = 0.85,
			width = 0.85,
			preview_cutoff = 0,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Tab>"] = actions.move_selection_next,
			},
		},
	},

	pickers = {
		find_files = {
			follow = true,
		},
		buffers = {
			sort_mru = true,
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = "ascending",
		},
		spell_suggest = themes.get_cursor(),
		lsp_workspace_symbols = {
			symbol_highlights = symbol_highlights,
		},
		lsp_document_symbols = {
			symbol_highlights = symbol_highlights,
		},
		commands = themes.get_dropdown(),
	},
	extensions = {
		file_browser = {
			hidden = true,
			depth = 3,
		},
		["ui-select"] = themes.get_dropdown(),
	},
	-- pickers = {
	-- },
})
