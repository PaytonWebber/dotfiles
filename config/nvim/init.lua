vim.loader.enable()

local version = vim.version

local core_config_files = {
    "globals",  -- global vim settings
    "plugins",  -- contains plugins and lazy loading
    "options",  -- settings for nvim
    "mappings", -- user-defined keybindings
}

-- Load core config files
for _, config_file in ipairs(core_config_files) do
    local module, _ = string.gsub(config_file, ".lua", "")
    package.loaded[module] = nil
    require(module)
end
