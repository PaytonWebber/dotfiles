-- Vim mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>b", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})

-- LSP pickers
vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>S", builtin.lsp_workspace_symbols, {})
vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gr", builtin.lsp_references, {})

-- Neotree
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
