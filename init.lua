local vim = vim
local opt = vim.opt

opt.nu = true
opt.rnu = true

--█▓▒░ Load plugins
require('plugin-list')

--█▓▒░ General configurations
require('options')
require('globals')

--█▓▒░ key mappings
require('mappings')

--█▓▒░ Plugin configurations
require('plugins')
--█▓▒░ Langauge server configuration
require('lsp')
--█▓▒░  Colors
require('colors')

-- cmd("source $HOME/.config/nvim/lib/roam.vim")
