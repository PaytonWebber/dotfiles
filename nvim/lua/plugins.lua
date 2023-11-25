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
require("lazy").setup {

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
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.catppuccin")
    --         vim.cmd([[colorscheme catppuccin]])
    --     end,
    -- },

    -- OneNord
    -- {
    --     "rmehri01/onenord.nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         require("config.onenord")
    --         vim.cmd([[colorscheme onenord]])
    --     end,
    -- },
    
    -- Everforest
    -- {
    --     "neanias/everforest-nvim",
    --     lazy = false, -- load immediately
    --     priority = 1000, -- load as early as possible
    --     config = function()
    --         -- require("config.everforest")
    --         vim.cmd([[colorscheme everforest]])
    --     end,
    -- },

    -- Dracula
    {
        "Mofiqul/dracula.nvim",
        lazy = false, -- load immediately
        priority = 1000, -- load as early as possible
        config = function()
            -- require("config.dracula")
            vim.cmd([[colorscheme dracula]])
        end,
    },

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
    
    { "github/copilot.vim" },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
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

    -- { "nvim-treesitter/nvim-treesitter-context", event = "BufRead" },

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
        config = function()
            require("config.lualine")
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        keys = { "<space>s" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("config.nvim-tree")
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

    -- Better vim motions
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    },

    -- Easy renaming plugin
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    -- Quick file switcher
    { "theprimeagen/harpoon" },

    -- Modern matchit implementation
    { "andymass/vim-matchup", event = "BufRead" },

    -- Better UI for some nvim actions
    { "stevearc/dressing.nvim" },

    -- Comment plugin
    { "tpope/vim-commentary", event = "VeryLazy" },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },

    -- The missing auto-completion for cmdline!
    { "gelguy/wilder.nvim" },

    -- Pandoc
    -- { "vim-pandoc/vim-pandoc" },
    -- { "vim-pandoc/vim-pandoc-syntax" },

    -- Markdown

    -- { "iamcco/markdown-preview.nvim" },

    -- Paint for better markdown headers
    -- {
    --     "folke/paint.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("config.paint")
    --     end,
    -- },

}

