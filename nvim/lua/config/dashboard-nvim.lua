local conf = {}
conf.header = {
	"                                                       ",
	"                                                       ",
	"                                                       ",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"                                                       ",
	"                                                       ",
	"                                                       ",
	"                                                       ",
}

conf.center = {
	{
		icon = "󰈞  ",
		desc = "Find  File                              ",
		action = "Telescope find_files",
		key = "<Leader> f f",
	},
	{
		icon = "󰈢  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		key = "<Leader> f o",
	},
	{
		icon = "󰈬  ",
		desc = "Project grep                            ",
		action = "Telescope live_grep",
		key = "<Leader> f g",
	},
	{
		icon = "  ",
		desc = "Open Nvim config                        ",
		action = "tabnew $MYVIMRC | tcd %:p:h",
		key = "<Leader> e v",
	},
	{
		icon = "  ",
		desc = "New file                                ",
		action = "enew",
		key = "e",
	},
	{
		icon = "󰗼  ",
		desc = "Quit Nvim                               ",
		-- desc = "Quit Nvim                               ",
		action = "qa",
		key = "q",
	},
}

require("dashboard").setup({
	theme = "doom",
	shortcut_type = "number",
	config = conf,
})
