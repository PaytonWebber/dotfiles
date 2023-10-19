require('telescope').setup({
    pickers = {
        current_buffer_fuzzy_find = {
            sorting_strategy = 'ascending',
    },
  },
})

-- THESE HAVE BEEN MOVED TO mappings.lua
--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

