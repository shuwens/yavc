local cmd = vim.cmd

cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
    local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

    print("Cloning packer..")
    -- remove the dir before cloning
    vim.fn.delete(packer_path, "rf")
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", "--depth", "20", packer_path })

    cmd("packadd packer.nvim")
    present, packer = pcall(require, "packer")

    if present then
        print("Packer cloned successfully.")
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end

packer.init({
    display = { open_fn = function() return require("packer.util").float({ border = "single" }) end,
        prompt_border = "single" },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    },
    auto_clean = true,
    compile_on_sync = true
    --    auto_reload_compiled = true
})

require("packer").startup(function(use)
    use { "wbthomason/packer.nvim" }

    -- nvim enhancements
    use { "tpope/vim-sleuth" } -- Auto configure indentation
    use { "tpope/vim-surround" }
    use { "gpanders/editorconfig.nvim" }
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
    use { 'nvim-telescope/telescope-fzy-native.nvim' }
    use { "folke/which-key.nvim" }
    use { 'RRethy/nvim-align' }

    -- GUI enhancements
    use { "machakann/vim-highlightedyank" } -- highlight yank
    use { "jaxbot/semantic-highlight.vim" } -- different color for every variable
    use { "windwp/nvim-autopairs" }
    use { "ntpeters/vim-better-whitespace" }
    use { "lukas-reineke/indent-blankline.nvim" }
    use { "p00f/nvim-ts-rainbow" }
    use { "tomasiser/vim-code-dark" }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end }

    -- Software dev tools
    use { "tpope/vim-fugitive" }
    use { "junegunn/gv.vim" } -- GV, GV!, GV?
    use { "rhysd/committia.vim" } -- better git commit layout
    use { "tpope/vim-dispatch", opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

    -- LSP support
    use { "neovim/nvim-lspconfig" }
    use { "williamboman/nvim-lsp-installer" }

    -- LSP utils
    use { "nvim-lua/lsp_extensions.nvim" } -- info and inlay hints
    use { "ray-x/lsp_signature.nvim" } -- function signatures
    use { "j-hui/fidget.nvim" } -- status
    use { "SmiteshP/nvim-navic" } -- display function name etc

    -- Coq
    use { "ms-jpq/coq_nvim", branch = "coq",
        requires = { { "ms-jpq/coq.artifacts", branch = "artifacts" },
            { "ms-jpq/coq.thirdparty", branch = "3p" } } }
    use { "folke/lua-dev.nvim" }

    -- Language support
    use { "stephpy/vim-yaml", ft = 'yaml', opt = true }
    use { "cespare/vim-toml", ft = 'toml', opt = true }
    use { "dag/vim-fish", ft = 'fish', opt = true }
    use { 'nvim-orgmode/orgmode', config = function() require('orgmode').setup {} end }
    use { "plasticboy/vim-markdown", ft = 'markdown', opt = true }
    use { "mzlogin/vim-markdown-toc", ft = 'markdown', opt = true }
    use { "alvan/vim-closetag" }

    -- Rust
    use { "simrat39/rust-tools.nvim" }
    -- C++ and Clang
    -- use("octol/vim-cpp-enhanced-highlight', {'for': ['cpp'] }
    -- use("drmikehenry/vim-headerguard', {'for': ['cpp', 'hpp'] }
    -- use("bfrg/vim-cpp-modern', {'for': ['cpp', 'hpp'] }
    -- use("arakashic/chromatica.nvim', {'for': ['cpp', 'hpp'] }
    -- use("rhysd/vim-clang-format', {'for': ['c', 'cpp', 'hpp'] }

    -- SQL
    use { "tami5/sql.nvim", rocks = { "sqlite", "luv" } }
    use { "tpope/vim-dadbod" }
    use { "kristijanhusak/vim-dadbod-completion" }
    use { "kristijanhusak/vim-dadbod-ui" }

    -- writing
    use { "junegunn/goyo.vim" } -- Goyo, Goyo!
    use { "junegunn/limelight.vim" } -- Limelight, Limelight!
    use { "rhysd/vim-grammarous" }

    -- LaTeX
    -- https://www.reddit.com/r/neovim/comments/idthcb/vimtex_vs_texlab/
end)
