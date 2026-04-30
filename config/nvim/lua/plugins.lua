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
        lazy = true,
        priority = 999,
        config = function()
            require("rose-pine").setup({ variant = "moon" })
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

    -- Nightfox
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 999,
    },

    -- Cyberdream
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                italic_comments = true,
                theme = {
                    saturation = 1.5,
                    highlights = {
                        Keyword = { fg = "#ff5ea0", bold = true },
                        ["@keyword"] = { fg = "#ff5ea0", bold = true },
                        ["@keyword.function"] = { fg = "#ff5ea0", bold = true },
                        ["@keyword.return"] = { fg = "#ff5ea0", bold = true },
                        ["@conditional"] = { fg = "#ff5ea0", bold = true },
                        ["@repeat"] = { fg = "#ff5ea0", bold = true },
                        Function = { fg = "#5ef1ff", bold = true },
                        ["@function"] = { fg = "#5ef1ff", bold = true },
                        ["@function.call"] = { fg = "#5ef1ff", bold = true },
                        ["@function.method"] = { fg = "#5ef1ff", bold = true },
                        ["@function.method.call"] = { fg = "#5ef1ff", bold = true },
                        ["@method"] = { fg = "#5ef1ff", bold = true },
                        ["@method.call"] = { fg = "#5ef1ff", bold = true },
                        Type = { fg = "#bd9cff", bold = true },
                        ["@type"] = { fg = "#bd9cff", bold = true },
                        ["@type.builtin"] = { fg = "#bd9cff", italic = true },
                        String = { fg = "#5eff6c" },
                        ["@string"] = { fg = "#5eff6c" },
                        Number = { fg = "#5ed4a8" },
                        ["@number"] = { fg = "#5ed4a8" },
                        ["@boolean"] = { fg = "#5ed4a8", bold = true },
                        Constant = { fg = "#ff5ef1" },
                        ["@constant"] = { fg = "#ff5ef1" },
                        ["@constant.builtin"] = { fg = "#ff5ef1", italic = true },
                        ["@constant.macro"] = { fg = "#ff5ef1", bold = true },
                        ["@variable"] = { fg = "#ffffff" },
                        ["@variable.builtin"] = { fg = "#ff5ef1", italic = true },
                        ["@variable.member"] = { fg = "#ffd85e", bold = true },
                        ["@variable.parameter"] = { fg = "#ffffff", italic = true },
                        ["@parameter"] = { fg = "#ffffff", italic = true },
                        ["@field"] = { fg = "#ffd85e", bold = true },
                        ["@property"] = { fg = "#ffd85e", bold = true },
                        ["@constructor"] = { fg = "#5ef1ff", bold = true },
                        ["@namespace"] = { fg = "#bd9cff", bold = true },
                        ["@module"] = { fg = "#bd9cff", bold = true },
                        ["@attribute"] = { fg = "#ff5ef1" },
                        ["@function.builtin"] = { fg = "#5ef1ff", italic = true },
                        ["@function.macro"] = { fg = "#ff5ef1", bold = true },
                        ["@type.qualifier"] = { fg = "#ff5ea0", bold = true },
                        ["@storageclass"] = { fg = "#ff5ea0", bold = true },
                        ["@operator"] = { fg = "#ff5ea0" },
                    },
                },
            })
            vim.cmd("colorscheme cyberdream")

            -- Force literal colors after colorscheme load — theme.highlights
            -- doesn't reliably win for these groups.
            vim.api.nvim_set_hl(0, "Number", { fg = "#5ed4a8" })
            vim.api.nvim_set_hl(0, "Float", { fg = "#5ed4a8" })
            vim.api.nvim_set_hl(0, "Boolean", { fg = "#5ed4a8", bold = true })
            vim.api.nvim_set_hl(0, "@number", { fg = "#5ed4a8" })
            vim.api.nvim_set_hl(0, "@number.float", { fg = "#5ed4a8" })
            vim.api.nvim_set_hl(0, "@boolean", { fg = "#5ed4a8", bold = true })

            -- LSP semantic tokens use language-suffixed groups
            -- (e.g. @lsp.type.property.c) that don't reliably inherit from
            -- their non-suffixed parent. Set them directly on LspAttach for
            -- whichever filetype is active.
            local property_hl = { fg = "#ffd85e", bold = true }
            local method_hl = { fg = "#5ef1ff", bold = true }
            local type_hl = { fg = "#bd9cff", bold = true }
            local macro_hl = { fg = "#ff5ef1", bold = true }
            local constant_hl = { fg = "#ff5ef1" }
            local var_hl = { fg = "#ffffff" }
            local param_hl = { fg = "#ffffff", italic = true }
            local keyword_hl = { fg = "#ff5ea0", bold = true }
            local number_hl = { fg = "#5ed4a8" }
            local boolean_hl = { fg = "#5ed4a8", bold = true }
            local string_hl = { fg = "#5eff6c" }

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "" then return end
                    local set = function(group, opts)
                        vim.api.nvim_set_hl(0, group .. "." .. ft, opts)
                    end

                    set("@lsp.type.property", property_hl)
                    set("@lsp.type.member", property_hl)
                    set("@lsp.type.field", property_hl)
                    set("@lsp.type.method", method_hl)
                    set("@lsp.type.function", method_hl)
                    set("@lsp.type.parameter", param_hl)
                    set("@lsp.type.variable", var_hl)
                    set("@lsp.type.type", type_hl)
                    set("@lsp.type.class", type_hl)
                    set("@lsp.type.struct", type_hl)
                    set("@lsp.type.enum", type_hl)
                    set("@lsp.type.enumMember", constant_hl)
                    set("@lsp.type.namespace", type_hl)
                    set("@lsp.type.macro", macro_hl)
                    set("@lsp.type.modifier", keyword_hl)
                    set("@lsp.type.keyword", keyword_hl)
                    set("@lsp.type.number", number_hl)
                    set("@lsp.type.boolean", boolean_hl)
                    set("@lsp.type.string", string_hl)

                    set("@lsp.typemod.property.classScope", property_hl)
                    set("@lsp.typemod.property.readonly", property_hl)
                    set("@lsp.typemod.property.fileScope", property_hl)
                    set("@lsp.typemod.property.globalScope", property_hl)
                    set("@lsp.typemod.property.functionScope", property_hl)
                    set("@lsp.typemod.property.static", property_hl)
                    set("@lsp.typemod.method.classScope", method_hl)
                    set("@lsp.typemod.method.readonly", method_hl)
                    set("@lsp.typemod.method.static", method_hl)
                    set("@lsp.typemod.function.readonly", method_hl)
                    set("@lsp.typemod.function.globalScope", method_hl)
                    set("@lsp.typemod.function.fileScope", method_hl)
                    set("@lsp.typemod.function.defaultLibrary", { fg = "#5ef1ff", bold = true, italic = true })
                    set("@lsp.typemod.variable.readonly", constant_hl)
                    set("@lsp.typemod.variable.globalScope", { fg = "#ffffff", bold = true })
                    set("@lsp.typemod.variable.defaultLibrary", { fg = "#ff5ef1", italic = true })
                    set("@lsp.typemod.parameter.readonly", param_hl)
                    set("@lsp.typemod.parameter.functionScope", param_hl)
                    set("@lsp.typemod.macro.globalScope", macro_hl)
                    set("@lsp.typemod.macro.fileScope", macro_hl)
                end,
            })
        end,
    },

    -- Synthwave '84
    {
        "artanikin/vim-synthwave84",
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
