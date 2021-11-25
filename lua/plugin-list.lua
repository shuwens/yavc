local cmd = vim.cmd

cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/opt/packer.nvim"

  print("Cloning packer..")
  -- remove the dir before cloning
  vim.fn.delete(packer_path, "rf")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path,
  })

  cmd("packadd packer.nvim")
  present, packer = pcall(require, "packer")

  if present then
    print("Packer cloned successfully.")
  else
    error(
    "Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer
    )
  end
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 600, -- Timeout, in seconds, for git clones
  },
  auto_clean = true,
  compile_on_sync = true,
  --    auto_reload_compiled = true
})

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- VIM enhancements
  use("ciaranm/securemodelines")
  use("tpope/vim-commentary")
  use({"tpope/vim-dispatch", opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}})
  use("tpope/vim-fugitive")
  use("tpope/vim-sleuth")						-- Auto configure indentation
  use("tpope/vim-surround")
  use("gpanders/editorconfig.nvim")
  use("airblade/vim-rooter")

  -- GUI enhancements
  use("machakann/vim-highlightedyank")		-- highlight yank
  use("jaxbot/semantic-highlight.vim")		-- different color for every variable
  use("ntpeters/vim-better-whitespace")
  use("p00f/nvim-ts-rainbow")
  use("lukas-reineke/indent-blankline.nvim")
  use("famiu/feline.nvim")
  use("kyazdani42/nvim-web-devicons")
  use({"NvChad/nvim-base16.lua",})
  use({
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  })

  -- nvim tools
  use("rhysd/committia.vim")					-- better git commit layout
  use({"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"})
  use("kdheepak/lazygit.nvim")
  use("windwp/nvim-autopairs")
  use("ahmedkhalf/project.nvim")
  use("folke/which-key.nvim")
  use("liuchengxu/vista.vim")
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use({
    "kyazdani42/nvim-tree.lua",
    opt = true,
    cmd = { "NvimTreeToggle" },
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      local tree = require('nvim-tree')
      tree.setup({})
    end
  })

  -- LSP support
  use("glepnir/lspsaga.nvim")
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp_extensions.nvim")			-- lsp signatures
  use("neovim/nvim-lspconfig")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })

  -- Coq
  use({
    "ms-jpq/coq_nvim",
    branch = "coq",
    requires = {
      {"ms-jpq/coq.artifacts", branch = "artifacts"},
      {"ms-jpq/coq.thirdparty", branch = "3p"},
    },
  })
  use("folke/lua-dev.nvim")

  -- Language support
  use({ "stephpy/vim-yaml", ft = 'yaml', opt = true })
  use({ "cespare/vim-toml", ft = 'toml', opt = true })
  use({ "dag/vim-fish", ft = 'fish', opt = true })
  use({ "jceb/vim-orgmode", ft = 'org', opt = true })
  use({ "plasticboy/vim-markdown", ft = 'markdown' ,opt = true })
  use({ "mzlogin/vim-markdown-toc", ft = 'markdown', opt = true })
  use("alvan/vim-closetag")

  -- Rust
  -- use("rust-lang/rust.vim")
  -- use({'simrat39/rust-tools.nvim', after = 'nvim-lspconfig',
  -- 	ft = { 'rust' }, event = { 'BufEnter Cargo.toml' },
  -- 	config = function() require'plugins.rust-tools' end })
  -- use({ "simrat39/rust-tools.nvim", ft = 'rust', config = 'require(plugins.rust-tools)', opt = true })
  use("simrat39/rust-tools.nvim")
  -- C++ and Clang
  --use("octol/vim-cpp-enhanced-highlight', {'for': ['cpp'] }
  --use("drmikehenry/vim-headerguard', {'for': ['cpp', 'hpp'] }
  --use("bfrg/vim-cpp-modern', {'for': ['cpp', 'hpp'] }
  --use("arakashic/chromatica.nvim', {'for': ['cpp', 'hpp'] }
  --use("rhysd/vim-clang-format', {'for': ['c', 'cpp', 'hpp'] }

  -- LaTeX
  --https://www.reddit.com/r/neovim/comments/idthcb/vimtex_vs_texlab/
  --use("lervag/vimtex', { 'for': ['tex', 'latex'] }
  use({ "rhysd/vim-grammarous", ft = {'tex', 'latex', 'markdown'} })

  -- Productivity tools
  use {'junegunn/fzf.vim', requires = {{'junegunn/fzf'}}}
  use {
    'alok/notational-fzf-vim',
    config = function() require('plugins.notational') end,
    cond = function() vim.fn.isdirectory(vim.fn.expand("~/Dropbox/GS/notes"))  end
  }

  -- use({ "godlygeek/tabular" })
  -- use({ "samgriesemer/vim-roam-md" })
  -- use({ "dkarter/bullets.vim" })
  -- use({
  -- 	"samgriesemer/vim-roam",
  -- 	requires = {
  -- 		{ "samgriesemer/wiki.vim" },
  -- 		{ "skywind3000/asyncrun.vim" },
  -- 		{ "samgriesemer/vim-roam-search" },
  -- 		{ "samgriesemer/vim-roam-task" },
  -- 	},
  -- })
end)
