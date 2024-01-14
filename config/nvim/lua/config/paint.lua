local hlmap = {
	["^#%s+(.-)%s*$"] = "Operator",
	["^##%s+(.-)%s*$"] = "Type",
	["^###%s+(.-)%s*$"] = "Constant",
	["^####%s+(.-)%s*$"] = "Number",
}

local highlights = {}
for pattern, hl in pairs(hlmap) do
	table.insert(highlights, {
		filter = { filetype = "pandoc" },
		pattern = pattern,
		hl = hl,
	})
end

require("paint").setup({

	--type@ PaintHighlight[]
	highlights = highlights,
})
