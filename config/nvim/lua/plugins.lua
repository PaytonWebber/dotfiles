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

-- Lazy load plugins
require("lazy").setup({

    ---------------------- THEMES -----------------------

    -- Tokyonight
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.tokyonight")
    --         vim.cmd([[colorscheme tokyonight]])
    --     end,
    -- },

    -- Catppuccin
    -- {
    --     "catppuccin/nvim",
    --     lazy = false,    -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.catppuccin")
    --         vim.cmd([[colorscheme catppuccin]])
    --     end,
    -- },

    -- Nordic
    -- {
    --     "AlexvZyl/nordic.nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.nordic")
    --         vim.cmd([[colorscheme nordic]])
    --     end,
    -- },

    -- Cyberdream
    -- {
    --     "scottmckendry/cyberdream.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("config.cyberdream")
    --         vim.cmd([[colorscheme cyberdream]])
    --     end,
    -- },

    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("config.gruvbox")
            vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- Kanagawa
    -- {
    --     "rebelot/kanagawa.nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.kanagawa")
    --         vim.cmd([[colorscheme kanagawa]])
    --     end,
    -- },

    -- Rose-Pine
    -- {
    --     "rose-pine/neovim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.rose-pine")
    --         vim.cmd([[colorscheme rose-pine]])
    --     end,
    -- },

    -- Dracula
    -- {
    --     "Mofiqul/dracula.nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         -- require("config.dracula")
    --         vim.cmd([[colorscheme dracula]])
    --     end,
    -- },

    ------------------------------------------------------

    -- CoPilot built with Lua
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({})
    --     end,
    -- },

    -- CoPilot built with Vimscript
    -- { "github/copilot.vim" },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion

    {
        "L3MON4D3/LuaSnip",
        version = "v2.3.0",
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),

                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },

                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-y>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),
            })

            sources = cmp.config.sources({
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })
        end,
    },

    -- Rust Tools
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    -- Debug Adapter Protocol (DAP) for Rust LSP
    { 'mfussenegger/nvim-dap' },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy", -- load when we really need it
        build = ":TSUpdate",
        config = function()
            require("config.treesitter")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        config = function()
            require("config.treesitter-context")
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
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
        "echasnovski/mini.files",
        version = false,
        config = function()
            require("config.mini-files")
        end,
    },

    -- Fancy statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("config.lualine")
        end,
    },

    -- Fancy start screen
    {
        "nvimdev/dashboard-nvim",
        config = function()
            require("config.dashboard-nvim")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- In-line diagnostics
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            icons = true,
        },
    },

    -- Highlighter for todo's
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.todo-comments")
        end,
    },

    -- Tmux better movements
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    -- Show indentation levels
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require("config.indent")
        end,
    },

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
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
        },
    },

    -- Quick file switcher
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Modern matchit implementation
    { "andymass/vim-matchup", event = "BufRead" },

    -- Comment plugin
    { "tpope/vim-commentary", event = "VeryLazy" },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },

    -- Surround plugin
    { "tpope/vim-surround",   event = "VeryLazy" },

    -- The missing auto-completion for cmdline!
    { "gelguy/wilder.nvim" },
})
