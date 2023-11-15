-- Vim mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", function() mark.add_file() end)
vim.keymap.set("n", "<C-e>", function() ui.toggle_quick_menu() end)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
