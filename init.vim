set shell=/bin/bash
let mapleader = "\<Space>"
let maplocalleader = ","

" ===========================================================================
"  PLUGINS
" ===========================================================================
set nocompatible
filetype off
set rtp+=~/dev/others/base16/vim/
call plug#begin('$HOME/.local/share/nvim/plugged')

"█▓▒░ Load plugins

"█▓▒░ VIM enhancements
" --------------------
Plug 'ciaranm/securemodelines'
" Plug 'editorconfig/editorconfig-vim'		" Assume an editor config is enforced
Plug 'tpope/vim-fugitive'
" Plug 'sheerun/vim-polyglot'				" I don't need this and it is buggy
" Plug 'justinmk/vim-sneak'					" Need to remember its syntax
Plug 'junegunn/vim-easy-align', {'for': ['tex', 'latex']}  " Make writing easy with align
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
" Plug 'tweekmonster/startuptime.vim'
Plug 'tpope/vim-sleuth' 					" Auto configure indentation
Plug 'jiangmiao/auto-pairs'					" Autopairs


"█▓▒░ GUI enhancements
" --------------------
Plug 'machakann/vim-highlightedyank'		" highlight yank
Plug 'Yggdroot/indentLine'
Plug 'jaxbot/semantic-highlight.vim'		" different color for every variable
Plug 'bounceme/poppy.vim'					" rainbow parens
Plug 'ntpeters/vim-better-whitespace'
" Plug 'romainl/vim-cool'					" disables search highlighting when you are done
" Plug 'RRethy/vim-illuminate'				" highlighting other uses of the current word
" Plug 'vim-airline/vim-airline'			" better status line
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
" Plug 'lilydjwg/colorizer'					" colorize text in the form
" Plug 'mbbill/undotree'
Plug 'rhysd/committia.vim'					" better git commit layout
" Plug 'andymass/vim-matchup', { 'for': ['tex', 'latex'] }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'godlygeek/tabular', { 'for': ['tex', 'latex'] }
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

"█▓▒░ Additional func..
" ----------------
Plug 'tpope/vim-dispatch'

"█▓▒░ Fuzzy finder
" ----------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"█▓▒░ Semantic language support
" -----------------------------
" Coc for completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'Shougo/echodoc.vim'					" Showing function signature and inline doc.

"█▓▒░ VIM editing enhancements
" ----------------------------
Plug 'inside/vim-search-pulse'

"█▓▒░ Syntactic language support
" ------------------------------
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'jceb/vim-orgmode'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'alvan/vim-closetag'

"█▓▒░ Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Plug 'arzg/vim-rust-syntax-ext', { 'for': 'rust' } " broken?

"█▓▒░ C++ and Clang
" Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp'] }
" Plug 'drmikehenry/vim-headerguard', {'for': ['cpp', 'hpp'] }
" Plug 'bfrg/vim-cpp-modern', {'for': ['cpp', 'hpp'] }
" Plug 'arakashic/chromatica.nvim', {'for': ['cpp', 'hpp'] }
" Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp', 'hpp'] }

"█▓▒░ LaTeX
" https://www.reddit.com/r/neovim/comments/idthcb/vimtex_vs_texlab/
" Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'rhysd/vim-grammarous', { 'for': ['tex', 'latex', 'markdown'] }

if !isdirectory(expand("$HOME/dev/others/base16"))
  Plug 'chriskempson/base16-vim'
endif
call plug#end()


"█▓▒░ Make pyenv and neovim work nice together
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
  set guicursor=
  autocmd OptionSet guicursor noautocmd set guicursor=
end

if !has('gui_running')
  set t_Co=256
endif

"█▓▒░ Plugin settings

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" ===========================================================================
"   Editor settings
" ===========================================================================
filetype plugin indent on                   " required
set autoindent
set encoding=utf-8                          " Set default encoding to UTF-8
set noshowmode                              " We show the mode with airline or lightline
set hidden                                  " Hides buffers instead of closing them
set nowrap                                  " do not wrap long lines by default
set nojoinspaces                            " Prevents inserting two spaces after punctuation on a join (J)
" I only use VIM from the terminals
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") != -1)
  set termguicolors                         " screen does not (yet) support truecolor
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "tmux-256color") != -1)
  set termguicolors                         " screen does not (yet) support truecolor
endif
if (match($TERM, "xterm") != -1)
  set termguicolors                         " for the vagrant linux box
endif

set printfont=:h14
set printencoding=utf-8
set printoptions=paper:letter

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" Set the width of the tab to 4 wide
" This gets overridden by vim-sleuth, so that's nice
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Settings needed for .lvimrc
set exrc
set secure

set noswapfile                              " Don't use swapfile

set tags=.git/tags

" Sane splits
set splitright                              " Split vertical windows right to the current windows
set splitbelow                              " Split horizontal windows below to the current windows

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
"set wildmode=list:longest
set wildmode=list:full
"set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

"Some tips from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" Use wide tabs
" set shiftwidth=4                            " 1 tab == 8 spaces
" set softtabstop=4                           " when hitting <BS>, pretend like a tab is removed, even if spaces
" set tabstop=4                               " a tab is eight spaces
" set noexpandtab                             " Don't use spaces instead of tabs
" set expandtab                               " Use spaces instead of tabs
" set smarttab                                " Be smart when using tabs ;)
" set shiftwidth=4                            " 1 tab == 4 spaces
" set tabstop=2                               " a tab is four spaces
" set softtabstop=2                           " when hitting <BS>, pretend like a tab is removed, even if spaces

" Get syntax
syntax on

" Wrapping options
set formatoptions=tc                        " wrap text and comments using textwidth
set formatoptions+=r                        " continue comments when pressing ENTER in I mode
set formatoptions+=q                        " enable formatting of comments with gq
set formatoptions+=n                        " detect lists for formatting
set formatoptions+=b                        " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch                               " Shows the match while typing
set ignorecase                              " Search case insensitive...
set smartcase                               " ... but not when search pattern contains upper case characters
set gdefault                                " search/replace "globally" (on a line) by default

" ==========================================================================
"    GUI settings
" ==========================================================================
set guioptions-=T                           " Remove toolbar
set vb t_vb=                                " No more beeps
set backspace=2                             " Backspace over newlines
set cmdheight=2
set tw=79
set cursorline
set cursorcolumn
"set nofoldenable
set foldmethod=marker                       " Only fold on marks
set ruler                                   " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw                              " don't update the display while executing macros<Paste>
set synmaxcol=500
set laststatus=2                            " always have a statusline
set relativenumber                          " Relative line numbers
set number                                  " Also show current absolute line
set diffopt+=iwhite	                        " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
  set diffopt+=indent-heuristic
endif
set colorcolumn=80                          " and give me a colored column
set showcmd                                 " Show (partial) command in status line.
set mouse=a                                 " Enable mouse usage (all modes) in terminals
set shortmess+=c                            " don't give |ins-completion-menu| messages.

" Make it so there are always ten lines below my cursor
set scrolloff=10

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

let g:sneak#s_next = 1

" better whitespace
" red #FF0000, coral #FF7F50, tomato #FF6347, orangered #FF4500, orange
" #FFA500, darkorange #FF8C00
"let g:better_whitespace_ctermcolor='<desired_color>'
let g:better_whitespace_guicolor='#FF4500'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0

set background=dark
hi Comment cterm=italic gui=italic
" extra setup that I might not need?
" hi Normal ctermbg=NONE
" hi Normal guibg=NONE

" Colors: Base16
let base16colorspace=256
let g:base16_shell_path="$HOME/dev/others/base16/shell/scripts/"
" colorscheme base16-atelier-dune
colorscheme base16-gruvbox-dark-hard

" Customize the highlight a bit.
" Make comments more prominent -- they are important.
call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" Make it clearly visible which argument we're at.
call Base16hi("LspSignatureActiveParameter", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")
" Would be nice to customize the highlighting of warnings and the like to make
" them less glaring. But alas

" LSP configuration
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
snippet = {
  -- REQUIRED by nvim-cmp. get rid of it once we can
  expand = function(args)
  vim.fn["vsnip#anonymous"](args.body)
end,
},
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
    },
  sources = cmp.config.sources({
  -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
  { name = 'nvim_lsp' },
  }, {
  { name = 'path' },
  }),
experimental = {
  ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
  { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>o', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Get signatures (and _only_ signatures) when in argument lists.
require "lsp_signature".on_attach({
doc_lines = 0,
handler_opts = {
  border = "none"
  },
})
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- List of installed LSP servers
if vim.fn.executable("bash-language-server") == 1 then
  lspconfig.bashls.setup {
    cmd = {
      "bash-language-server",
      "start"
      },
    filetypes = {
      "sh",
      "zsh"
      },
    root_dir = lspconfig.util.root_pattern(".git"),
    on_attach = on_attach
    }
end

if vim.fn.executable("rust-analyzer") > 0 then
  lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    checkOnSave = {
      command = "clippy"
      },
    flags = {
      debounce_text_changes = 150,
      },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          },
        },
      },
    capabilities = capabilities,
    }
end
if vim.fn.executable("pyright") > 0 then
  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
" imap <Tab> <Plug>(completion_smart_tab)
" imap <S-Tab> <Plug>(completion_smart_s_tab)


" the configuration options should be placed before `colorscheme forest-night`
" let g:forest_night_enable_italic = 1
" let g:forest_night_disable_italic_comment = 1
" colorscheme forest-night

" Editing setup
source $HOME/.config/nvim/lib/editing.vim

" Syntax support
source $HOME/.config/nvim/lib/syntax.vim

" lightline as status line
source $HOME/.config/nvim/lib/lightline.vim

" EoF
