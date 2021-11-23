local vim = vim

local opt = vim.opt
local cmd = vim.cmd

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

-- Syntax support
-- cmd("source $HOME/.config/nvim/lib/syntax.vim")
