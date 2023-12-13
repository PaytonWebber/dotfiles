vim.loader.enable()

local version = vim.version

local core_config_files = {
	"globals.lua", -- global vim settings
	"plugins.lua", -- contains plugins and lazy loading
	"options.lua", -- settings for nvim
	"mappings.lua", -- user-defined keybindings
}

-- Load core config files
for _, config_file in ipairs(core_config_files) do
	local module, _ = string.gsub(config_file, ".lua", "")
	package.loaded[module] = nil
	require(module)
end
