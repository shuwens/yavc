local vim = vim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ","

require('lazy').setup({
    { 'folke/lazy.nvim' },
    -- nvim enhancements
    { 'tpope/vim-sleuth' }, -- Auto configure indentation
    { 'gpanders/editorconfig.nvim' },
    {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
    },
    { 'RRethy/nvim-align' },

    -- Theme
    -- https://github.com/Civitasv/runvim/blob/e712f0176ee22f3c268bde65c5a468c09a6f8752/lua/plugins/kanagawa.lua#L4
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- GUI enhancements
    { 'nvim-lualine/lualine.nvim' },
    { 'jaxbot/semantic-highlight.vim' }, -- different color for every variable
    { 'windwp/nvim-autopairs' },
    { 'ntpeters/vim-better-whitespace' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'HiPhish/rainbow-delimiters.nvim' },
    -- {
    --     'lewis6991/gitsigns.nvim',
    --     event = { 'BufReadPost', 'BufNewFile' },
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     config = function() require('gitsigns').setup() end
    -- },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('todo-comments').setup {}
        end
    },

    -- Software dev tools
    { 'tpope/vim-fugitive', event = 'VeryLazy' },
    { 'rhysd/committia.vim' }, -- better git commit layout
    -- https://github.com/zbirenbaum/copilot-cmp
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { "folke/neodev.nvim",                        opts = {} },
    -- DAP Support
    {
        "mfussenegger/nvim-dap",
        config = function() end,
    },
    { "nvim-neotest/nvim-nio" },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'rcarriga/nvim-dap-ui' },

    -- LSP support
    { 'VonHeikemen/lsp-zero.nvim',                branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'simrat39/inlay-hints.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'onsails/lspkind.nvim' },

    -- LSP utils
    { 'nvim-lua/lsp_extensions.nvim' }, -- info and inlay hints
    { 'ray-x/lsp_signature.nvim' },     -- function signatures
    {
        'j-hui/fidget.nvim',            -- lsp status
        event = "LspAttach",
        opts = {
            notification = { window = { winblend = 0 } },
            logger = { level = vim.log.levels.OFF },
            progress = {
                suppress_on_insert = true,
                display = { render_limit = 3 },
                ignore = { -- List of LSP servers to ignore
                    'efm',
                    'null-ls',
                },
            },
        },
        -- config = function() require('fidget').setup {} end
    },
    { 'SmiteshP/nvim-navic' }, -- display function name etc
    { 'folke/lua-dev.nvim' },
    { 'chrisbra/Colorizer' },

    -- Language support
    -- LaTeX
    -- https://www.reddit.com/r/neovim/comments/idthcb/vimtex_vs_texlab/
    { 'stephpy/vim-yaml',         ft = 'yaml' },
    { 'cespare/vim-toml',         ft = 'toml' },
    { 'dag/vim-fish',             ft = 'fish' },
    { 'nvim-orgmode/orgmode',     config = function() require('orgmode').setup {} end },
    { 'plasticboy/vim-markdown',  ft = 'markdown' },
    { 'mzlogin/vim-markdown-toc', ft = 'markdown' },
    { 'alvan/vim-closetag' },
    {
        "vim-pandoc/vim-pandoc",
        ft = { "markdown", "pandoc", "latex" },
        -- config = function()
        --     require("plugins.pandoc")
        -- end,
        event = "VeryLazy",
    },
    {
        "vim-pandoc/vim-pandoc-syntax",
        ft = { "markdown", "pandoc", "latex" },
        event = "VeryLazy",
    },

    -- Rust
    -- { 'simrat39/rust-tools.nvim' },
    -- C++ and Clang
    -- { 'octol/vim-cpp-enhanced-highlight', ft = { 'c', 'cpp' } },
    -- { 'drmikehenry/vim-headerguard',      ft = { 'c', 'cpp' } },
    -- { 'bfrg/vim-cpp-modern',              ft = { 'c', 'cpp' } },
    -- { 'arakashic/chromatica.nvim',        ft = { 'c', 'cpp' } },
    -- { 'rhysd/vim-clang-format',           ft = { 'c', 'cpp' } },

    -- SQL
    -- { "tami5/sql.nvim", rocks = { "sqlite", "luv" } }
    -- { 'tpope/vim-dadbod' },
    -- { 'kristijanhusak/vim-dadbod-completion' },
    -- { 'kristijanhusak/vim-dadbod-ui' },

    -- writing
    {
        'junegunn/goyo.vim', -- Goyo, Goyo!
        lazy = false,
        config = function()
            vim.g.goyo_width = '55%' -- Default width
            -- vim.g.goyo_height = '90%' -- Default height
        end
    },
    { 'junegunn/limelight.vim' }, -- Limelight, Limelight!
    { 'rhysd/vim-grammarous' },
    -- https://github.com/airbornelamb/vim-academic
    { 'airbornelamb/vim-academic' },

    -- note taking
    -- https://mischavandenburg.com/zet/neovim-zettelkasten/
    {
        'mickael-menu/zk-nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('zk').setup({
                picker = 'telescope',
                lsp = {
                    config = {
                        cmd = { 'zk', 'lsp' },
                        name = 'zk',
                    },
                    auto_attach = {
                        enabled = true,
                        filetypes = { 'markdown' },
                    },
                },
            })
        end
    },
    -- fun
    { 'ThePrimeagen/vim-be-good' }
})
