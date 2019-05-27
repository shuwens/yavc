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
Plug 'vim-scripts/localvimrc'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'   " I don't need this and it is buggy
Plug 'tpope/vim-sleuth'  " Heuristically set buffer options
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sensible'

"█▓▒░ GUI enhancements
" --------------------
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'Yggdroot/indentLine'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'bounceme/poppy.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'romainl/vim-cool'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"█▓▒░ Fuzzy finder
" ----------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'		    " Fuzzy finder (install fzf cmd line tool)
if !empty(glob("/usr/local/opt/fzf"))
  Plug '/usr/local/opt/fzf'
  set rtp+=/usr/local/opt/fzf
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  set rtp+=~/.fzf
endif

"█▓▒░ Semantic language support
" -----------------------------
" Coc for completion
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" and ALE for linting
Plug 'w0rp/ale'
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

"█▓▒░ VIM editing enhancements
" ----------------------------
Plug 'RRethy/vim-illuminate'
Plug 'inside/vim-search-pulse'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'lilydjwg/colorizer'
if !empty(glob("~/notes"))
  Plug 'Alok/notational-fzf-vim'
endif
if has("mac") || has("macunix")
  Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
endif

"█▓▒░ Syntactic language support
" ------------------------------
Plug 'vim-scripts/gnuplot-syntax-highlighting'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'jceb/vim-orgmode'
Plug 'bfrg/vim-cpp-modern'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'arakashic/chromatica.nvim'

"█▓▒░ Rust
Plug 'rust-lang/rust.vim'

"█▓▒░ LaTeX
"Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'rhysd/vim-grammarous'
Plug 'ron89/thesaurus_query.vim'

"█▓▒░ Color
if !isdirectory("$HOME/dev/others/base16")
  Plug 'chriskempson/base16-vim'
endif
call plug#end()

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
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set noshowmode
set hidden
set nowrap
set nojoinspaces
" I only use VIM from the terminals
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") != -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
if (match($TERM, "xterm") != -1)
  " for the vagrant linux box
  set termguicolors
endif

set printfont=:h14
set printencoding=utf-8
set printoptions=paper:letter

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

set tags=.git/tags

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Get syntax
syntax on

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" ==========================================================================
"    GUI settings
" ==========================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set cmdheight=2
set tw=79
set cursorline
set cursorcolumn
"set nofoldenable
set foldmethod=marker " Only fold on marks
set ruler " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
  set diffopt+=indent-heuristic
endif
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" better whitespace
" red #FF0000, coral #FF7F50, tomato #FF6347, orangered #FF4500, orange
" #FFA500, darkorange #FF8C00
"let g:better_whitespace_ctermcolor='<desired_color>'
let g:better_whitespace_guicolor='#FF4500'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0

" Colors: Base16
set background=dark
let base16colorspace=256
let g:base16_shell_path="$HOME/dev/others/base16/shell/scripts/"
colorscheme base16-atelier-dune
" extra setup that I might not need?
hi Normal ctermbg=NONE
hi Normal guibg=NONE

" Editing setup
source $HOME/.config/nvim/lib/editing.vim

" Syntax support
source $HOME/.config/nvim/lib/syntax.vim

" ===========================================================================
"   Personal programming setup
" ===========================================================================
source $HOME/.config/nvim/lib/airline.vim
source $HOME/.config/nvim/lib/coc.vim
source $HOME/.config/nvim/lib/ale.vim

" echodoc
let g:echodoc_enable_at_startup = 1

if has('nvim')
  runtime! plugin/python_setup.vim
endif
