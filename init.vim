set shell=/bin/bash
let mapleader = "\<Space>"
let maplocalleader = ","

set nocompatible
filetype off
set rtp+=~/dev/others/base16/vim/

"█▓▒░ Load plugins
lua require('plugin-list')
"█▓▒░ General configurations
lua require('options')
"█▓▒░ Plugin configurations
lua require('plugins')
"█▓▒░  Langauge server configuration
lua require('lsp')
"█▓▒░  Colors
lua require('colors')

"█▓▒░ Make pyenv and neovim work nice together
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
  " set guicursor=
  " autocmd OptionSet guicursor noautocmd set guicursor=
end
if !has('gui_running')
  set t_Co=256
endif

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" Editor settings {{{
filetype plugin indent on                   " required
set autoindent
set encoding=utf-8                          " Set default encoding to UTF-8
set noshowmode                              " We show the mode with airline or lightline
set hidden                                  " Hides buffers instead of closing them
set nowrap                                  " do not wrap long lines by default
set nojoinspaces                            " Prevents inserting two spaces after punctuation on a join (J)
" I only use VIM from the terminals
set termguicolors                         " screen does not (yet) support truecolor

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
" }}}

" GUI settings {{{
set guioptions-=T                           " Remove toolbar
set vb t_vb=                                " No more beeps
set backspace=2                             " Backspace over newlines
set cmdheight=2
set tw=79
set cursorline
set cursorcolumn
" set nofoldenable
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

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Make it so there are always ten lines below my cursor
set scrolloff=10

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" better whitespace
" red #FF0000, coral #FF7F50, tomato #FF6347, orangered #FF4500, orange #FFA500, darkorange #FF8C00
"let g:better_whitespace_ctermcolor='<desired_color>'
let g:better_whitespace_guicolor='#FF4500'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0

set background=dark
let base16colorspace=256
let g:base16_shell_path="$HOME/dev/others/base16/shell/scripts/"
colorscheme base16-gruvbox-dark-hard  " base16-atelier-dune
hi Normal ctermbg=NONE

" Customize the highlight a bit.
" Make comments more prominent -- they are important.
call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" Make it clearly visible which argument we're at.
call Base16hi("LspSignatureActiveParameter", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")
" Would be nice to customize the highlighting of warnings and the like to make
" them less glaring. But alas

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" }}} 

" Editing setup
source $HOME/.config/nvim/lib/editing.vim

" Syntax support
source $HOME/.config/nvim/lib/syntax.vim
