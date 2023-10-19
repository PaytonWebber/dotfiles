require("toggleterm").setup({
    open_mapping = "<C-j>",
    direction = "float",
    autochdir = true,

    float_opts = {
        border = "curved",
        width = 100,
        height = 30,
        winblend = 3,
    },
})
