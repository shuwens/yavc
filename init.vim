set shell=/bin/bash

"█▓▒░ Load plugins
lua require('plugin-list')

"█▓▒░ General configurations
lua require('options')
lua require('globals')

"█▓▒░ key mappings
lua require('mappings')

"█▓▒░ Plugin configurations
lua require('plugins')
"█▓▒░  Langauge server configuration
lua require('lsp')
"█▓▒░  Colors
lua require('colors')

" Editing setup
" source $HOME/.config/nvim/lib/editing.vim

" Syntax support
source $HOME/.config/nvim/lib/syntax.vim
