vim.g.mapleader = " "
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
