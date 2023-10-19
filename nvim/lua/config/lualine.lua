require("lualine").setup {
    options = {
        theme = "nord",
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
