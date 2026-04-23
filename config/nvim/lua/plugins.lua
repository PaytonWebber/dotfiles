local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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

-- Lazy load plugins
require("lazy").setup({

    ---------------------- THEMES -----------------------

    -- Rose Pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({ variant = "moon" })
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Everforest
    {
        "sainnhe/everforest",
        lazy = true,
        priority = 999,
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 999,
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
        end,
    },

    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        priority = 999,
    },

    -- Github
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = true,
        priority = 999,
        config = function()
            require("github-theme").setup({})
        end,
    },

    ------------------------------------------------------
    -- LSP
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },

        version = "1.*",

        opts = {
            keymap = { preset = "enter" },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },


    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "saghen/blink.cmp" },
        },
        opts = {
            servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
                dartls = {},
                lua_ls = {},
                rust_analyzer = {},
                ts_ls = {},
                zls = {},
            },
        },
        config = function(_, opts)
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end,
    },

    -- Rust Tools
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    -- Debug Adapter Protocol (DAP)
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            require("config.dap")
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

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("config.telescope")
        end,
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        opts = {},
    },

    -- Fancy statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("config.lualine")
        end,
    },

    -- In-line diagnostics
    {
        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        opts = {}
    },

    -- Highlighter for todo's
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    -- Tmux better movements
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    -- Show indentation levels
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = {},
    -- },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        config = function()
            require("config.conform")
        end,
    },

    -- Better vim motions
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "gw",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            }
        },
    },

    -- Quick file switcher
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },


    -- Git changes
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add       = { text = "│" },
                    change    = { text = "│" },
                    delete    = { text = "_" },
                    topdelete = { text = "‾" },
                },
                signcolumn = true, -- show in sign column
                numhl = true,
                linehl = false,
                word_diff = false,
                current_line_blame = false,
                on_attach = function() end, -- no extra keymaps
            })
        end,
    },

    -- Automatic insertion and deletion of a pair of characters
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {}
    },
})
