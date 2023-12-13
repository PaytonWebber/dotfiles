-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indentation
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backupdir"
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 26

-- Make the cursor always be in the middle of the screen
