require("lualine").setup {
    options = {
        theme = "gruvbox",
        icons_enabled = true
    },
    sections = {
        lualine_a = {
            {
            "filename",
            path = 1,
            }
        }
    }
}
