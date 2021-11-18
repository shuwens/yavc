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
	use("tpope/vim-sleuth")  -- Auto configure indentation
	use("tpope/vim-surround")
	use("folke/which-key.nvim")

	-- GUI enhancements
	use({
		'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
	})
	use("machakann/vim-highlightedyank")  -- highlight yank
	use("Yggdroot/indentLine")
	use("jaxbot/semantic-highlight.vim")  -- different color for every variable
	use("ntpeters/vim-better-whitespace")
	use("rhysd/committia.vim")  -- better git commit layout
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("kdheepak/lazygit.nvim")
	use("p00f/nvim-ts-rainbow")
	use("lukas-reineke/indent-blankline.nvim")
	use("famiu/feline.nvim")
	use("windwp/nvim-autopairs")
	use("ahmedkhalf/project.nvim")
	use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
	use("kyazdani42/nvim-web-devicons")
	use({"NvChad/nvim-base16.lua",})
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
	use("kabouzeid/nvim-lspinstall")
	use("neovim/nvim-lspconfig")
	use("nvim-lua/lsp_extensions.nvim")  -- lsp signatures
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
	use("gpanders/editorconfig.nvim")

	-- Language support
	use("stephpy/vim-yaml")
	use("cespare/vim-toml")
	use("dag/vim-fish")
	use("jceb/vim-orgmode")
	use("plasticboy/vim-markdown")
	use("mzlogin/vim-markdown-toc")
	use("alvan/vim-closetag")

	-- Rust
	-- use("rust-lang/rust.vim")
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
	use({
		"rhysd/vim-grammarous",
		ft = {'tex', 'latex', 'markdown'},
	})
	-- use("airblade/vim-rooter'
	-- use("junegunn/fzf', { 'do': { -> fzf#install() } }
	-- use("junegunn/fzf.vim'

end)
