local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Check if firenvim is active
local firenvim_not_active = function()
    return not vim.g.started_by_firenvim
end

-- Lazy load plugins
require("lazy").setup {

    -- Nord
    {
        "shaunsingh/nord.nvim",
        lazy = false, -- load immediately
        priority = 0, -- load as early as possible
        config = function()
            vim.cmd([[colorscheme nord]])
        end,
    },

    -- CoPilot
    {
        "github/copilot.vim",
    },

    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",

        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function()
            require("config.lsp")
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy", -- load when we really need it
        build = ":TSUpdate",
        config = function()
            require("config.treesitter")
        end,
    },

    { "nvim-treesitter/playground", event = "BufRead" },

    { "nvim-treesitter/nvim-treesitter-context", event = "BufRead" },

    --TeleScope
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        
        cmd = "Telescope",
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        },
        config = function()
            require("config.telescope")
        end,
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

    -- Fancy statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        cond = firenvim_not_active,
        config = function()
            require("config.lualine")
        end,
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        keys = { "<space>s" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("config.nvim-tree")
        end,
    },

    -- fancy start screen
    {
        "nvimdev/dashboard-nvim",
        cond = firenvim_not_active,
        config = function()
            require("config.dashboard-nvim")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- In-line diagnostics
    {
        "folke/trouble.nvim",
	cmd = "Trouble",
        config = function()
            require("config.trouble")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Modern matchit implementation
    { "andymass/vim-matchup", event = "BufRead" },

    -- Auto format tools
    { "sbdchd/neoformat", cmd = { "Neoformat" } },

    -- better UI for some nvim actions
    { "stevearc/dressing.nvim" },

    -- comment plugin
    { "tpope/vim-commentary", event = "VeryLazy" },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },

    -- The missing auto-completion for cmdline!
    { "gelguy/wilder.nvim" },

    -- pop-up terminal
    {
        "akinsho/toggleterm.nvim",
        keys = { "<C-j>" },
        config = function()
            require("config.toggleterm")
        end,
    },
}
