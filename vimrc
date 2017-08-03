" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
set nocompatible
filetype off
"set rtp+=~/dev/others/base16/builder/templates/vim/
call plug#begin('~/.vim/plugged')

" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
"Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'

" rainbow_parentheses
Plug 'kien/rainbow_parentheses.vim'
Plug 'raymond-w-ko/vim-niji'

" Semantic support
"Plug 'Raimondi/delimitMate'
Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-rooter'
Plug 'szw/vim-tags'
Plug 'jiangmiao/auto-pairs'    "vim-scripts/paredit.vi
Plug 'tpope/vim-speeddating'
Plug 'jgdavey/tslime.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Neosnippet
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" ================================
" Syntactic language support
" ================================
Plug 'vim-scripts/gnuplot-syntax-highlighting'
"Plug 'treycordova/rustpeg.vim.git'
Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
" Be-trusted C/C++ FIXME
Plug 'WolfgangMehner/c-support' 
" Golang
Plug 'fatih/vim-go'   " for golang
Plug 'rjohnsondev/vim-compiler-go'
Plug 'dgryski/vim-godef'
" Python
Plug 'klen/python-mode'   " for python
" install jedi-vim and let g:pymode_rope = 1
Plug 'dag/vim-fish'
Plug 'rhysd/vim-clang-format'
Plug 'jceb/vim-orgmode'  "org mode
" SICP
Plug 'kovisoft/slimv'
Plug 'jpalardy/vim-slime'
" Clojure
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
" Haskell
Plug 'dag/vim2hs'
Plug 'vim-scripts/haskell.vim'
"Plug 'eagletmt/ghcmod-vim'
"Plug 'eagletmt/neco-ghc'
"Plug 'tomtom/tlib_vim'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'
"Plug 'scrooloose/nerdcommenter'
"Plug 'bitc/vim-hdevtools'
"Plug 'neovimhaskell/haskell-vim'
"Plug 'kana/vim-filetype-haskell', {'do': 'make'}
" Java FIXME
" https://julien.ponge.org/blog/java-coding-with-style/
" eclim

" Buffer
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
Plug 'jlanzarotta/bufexplorer'

" Color scheme
" https://github.com/morhetz/gruvbox/wiki/Configuration
Plug 'morhetz/gruvbox'
Plug 'AlessandroYorba/Sierra'

" Linux kernel coding
Plug 'vivien/vim-linux-coding-style'

" Disdration free
Plug 'junegunn/goyo.vim'
Plug 'https://github.com/amix/vim-zenroom2'

" Tools
Plug 'tpope/vim-fugitive'

" TESTING
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

"Plug 'ludovicchabant/vim-gutentags'
" vim easytags is very good however it is no longer maintained
"Plug 'xolox/vim-easytags' 
Plug 'xolox/vim-misc'

Plug 'mtth/scratch.vim'  " TODO

" Arch Linux pkgbuild
Plug 'dracorp/vim-pkgbuild'

call plug#end()


" =============================================================================
" Editor settings
" =============================================================================
filetype plugin indent on
set ts=2
set autoindent
set smartindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set nowrap
set nojoinspaces
" Turn backup off, since most things are in git
set nobackup
set nowb
set noswapfile

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

" Use wide tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set noexpandtab

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

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
"nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set foldmethod=marker " Only fold on marks
set ruler " Where am I?
set number
set ttyfast
set lazyredraw
set laststatus=2
set cmdheight=2
" cursor line and column
set cursorline

set tabstop=2
set backspace=indent,eol,start " Delete everything with backspace
set shiftwidth=2 " Tabs under smart indent
set shiftround
set cindent
set autoindent
set smarttab
set expandtab

" Note that using urxvt will need to get rid of it to make it work, but it is
" required in xterm-256
if $TERM=~"terminator"
  " Colors
  set background=dark
  colorscheme base16-atelier-dune
  " Personal settings
  autocmd BufEnter *.go colorscheme sierra
  autocmd BufEnter *.c  colorscheme sierra
  autocmd BufEnter *.py  colorscheme sierra
  autocmd BufEnter *.h  colorscheme sierra
  autocmd BufEnter *.hpp  colorscheme sierra
  autocmd BufEnter *.cpp  colorscheme sierra
  hi Normal ctermbg=NONE
  " Base16
  "let base16colorspace=256
  "set t_Co=256
  "let g:base16_shell_path="~/dev/others/base16/builder/templates/shell/scripts/"
  set termguicolors
  set cursorcolumn
endif
if $TERM=~"rxvt-unicode"
  set background=dark
  set t_Co=256
  highlight SpecialKey ctermfg=11 ctermbg=8
  colorscheme gruvbox
endif
if $TERM=~"xterm-256color"
  set background=dark
  set t_Co=256
  highlight SpecialKey ctermfg=11 ctermbg=8
  colorscheme gruvbox
endif


set relativenumber " Relative line numbers
set diffopt+=iwhite " No whitespace in vimdiff
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mousehide
"set mouse=a " Enable mouse usage (all modes) in terminals
set completeopt-=preview
set completeopt=longest,menu
set complete=.,w,b,u,U
" Tabs / Buffers settings
tab sball
set switchbuf=useopen

" Add highlighting to TODO,NOTE,etc
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
"set nolist
"set listchars=nbsp:¬,extends:»,precedes:«,trail:•
set list
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:»\ ,eol:¬

" Show trailing spaces as dots and carrots for extended lines.
" From Janus, http://git.io/PLbAlw

" Reset the listchars
set listchars=""
" make tabs visible
set listchars=tab:▸▸
" show trailing spaces as dots
set listchars+=trail:•
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<
" I like my eol
set listchars+=eol:¬

" =============================================================================
" Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Suspend with Ctrl+f
inoremap <C-z> :sus<cr>
vnoremap <C-z> :sus<cr>
nnoremap <C-z> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" Second thought: keep left and right in insert will be sane
noremap <left> <nop>
noremap <right> <nop>

" Move by line
nnoremap j gj
nnoremap k gk

" Jump to next/previous error
noremap <C-j> :cn<cr>
nnoremap <C-k> :cp<cr>
"nnoremap <C-l> :copen<cr>
"nnoremap <C-h> :cclose<cr>

" ,, toggles between buffers
nnoremap ,, <c-^>

" ,= indents current 'section' (e.g. HTML tag)
nnoremap <leader>> Vat>
nnoremap <leader>< Vat<

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_
noremap <leader>n ct-

" M to make
noremap M :!make -k -j4<cr>

" I can type :help on my own, thanks.
"map <F1> <Esc>
noremap <F1> <Esc>
imap <F1> <Esc>

nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
"nmap <silent> <leader>s :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

" ----------------------
" From ultimate vim
" ----------------------
" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command SW w !sudo tee % > /dev/null

" From ultimate vim
map <leader>o :BufExplorer<cr>
map <leader>f :MRU<CR>

map <leader>z :Goyo<cr>

" Close current buffer
map <leader>bd :Bclose<cr>

" Close all buffers
map <leader>ba :1,1000 bd!<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>0 :e ~/buffer<cr>
map <leader>pp :setlocal paste!<cr>

" Visual mode mappings
"vnoremap <silent> * :call VisualSelection('f')<CR>
"vnoremap <silent> # :call VisualSelection('b')<CR>
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" ALE
let &runtimepath.=',~/.vim/bundle/ale'

" cmd helper
cno ' <C-\>eDeleteTillSlash()<cr>
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>
cnoremap <C-K>  <C-U>

cnoremap <C-P>  <Up>
cnoremap <C-N>  <Down>

" Auto Pair
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
"nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>qq :q!<Esc>:q!<CR>

" map wincmd {{
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" using ctrl hj"
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>h :wincmd h<CR>
nmap <leader>l :wincmd l<CR>
" The right windcmd
nmap <silent>J :wincmd j<CR>
nmap <silent>K :wincmd k<CR>
nmap <silent>H :wincmd h<CR>
nmap <silent>L :wincmd l<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Per-buffer CtrlP hotkey
nmap <leader>; :CtrlPBuffer<CR>
nmap <leader>o :CtrlP<CR>

noremap <leader>fa :<c-u>CtrlPBookmarkDir<CR>
noremap <leader>fb :<c-u>CtrlPBuffer<CR>
noremap <leader>fc :<c-u>CtrlPChange<CR>
noremap <leader>fd :<c-u>CtrlPDir<CR>
noremap <leader>; :<c-u>CtrlP<CR>
noremap <leader>fl :<c-u>CtrlPLine<CR>
noremap <leader>fm :<c-u>CtrlPMRU<CR>
noremap <leader>fr :<c-u>CtrlP <C-R>=expand('%:p:h')<CR><CR>
noremap <leader>ft :<c-u>CtrlPTag<CR>
noremap <leader>fq :<c-u>CtrlPQuickfix<CR>

nnoremap <leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
map <C-F12> :!ctags -R -f ./.git/tags .<CR>

nnoremap <C-g> <C-]>
vnoremap <C-g> <C-]>
"map <C-h> :tn<CR>
"map <C-f> :tp<CR>
map <C-o> :CtrlPTag<CR>
map <C-i> :TagbarToggle<CR>

map <F4> :w<CR> :compiler gradle<CR> :make test<CR>:cw 4<CR>

" ----------------------
" Plugin settings
" ----------------------

let g:secure_modelines_allowed_items = [
      \ "textwidth",   "tw",
      \ "softtabstop", "sts",
      \ "tabstop",     "ts",
      \ "shiftwidth",  "sw",
      \ "expandtab",   "et",   "noexpandtab", "noet",
      \ "filetype",    "ft",
      \ "foldmethod",  "fdm",
      \ "readonly",    "ro",   "noreadonly", "noro",
      \ "rightleft",   "rl",   "norightleft", "norl",
      \ "colorcolumn"
      \ ]

" Airline + CtrlP
let g:airline_powerline_fonts = 1
let g:airline_theme = "base16"
let g:ctrlp_root_markers = ['.lvimrc', '.git']
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|publish$\|intermediate$\|node_modules$\|components$\|target$',
      \ 'file': '\~$\|\.png$\|\.jpg$\|\.gif$\|\.settings$\|Thumbs\.db\|\.min\.js$\|\.swp\|\.o$\|\.hi$\|.a$\|.sqlite3$\|.key$\|.pub$\|.racertmp$',
      \ }

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir node_modules --ignore-dir target -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Neomake
" ...

" Doxygen
let mysyntaxfile='~/.vim/doxygen_load.vim'

" DEPRECATED {{{
" Don't confirm .lvimrc
let g:localvimrc_ask = 0
" language server protocol
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rustup', 'run', 'nightly', 'cargo', 'run', '--release', '--manifest-path=/home/jon/dev/others/rls/Cargo.toml'],
"    \ }
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" }}}

" ======================================
"  Lang specific settings
" ======================================

" racer + rust {{{
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 1
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
" }}}

" Golang {{{
" vim-go 
" From https://gist.github.com/cridenour/74e7635275331d5afa6b
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
"au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)

" my config 
let g:go_play_open_browser = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_interfaces = 1
"au FileType go nmap <Leader>gD <Plug>(go-doc-vertical)
"au FileType go nmap <Leader>gDB <Plug>(go-doc-browser)
"au FileType go nmap <Leader>gR <Plug>(go-run)
au FileType go nmap <leader>gv <Plug>(go-build)
au FileType go nmap <leader>gT <Plug>(go-test)
" In case guru is not working, http://studygolang.com/articles/9718
au FileType go nmap <C-]> :GoDef<cr>
au Filetype go nmap <leader>j :GoDecls<cr>
" }}}

" python-mode {{{
"
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1
" Documentation
let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
"Linting
nmap <leader>l :PymodeLint<CR>
"let g:pymode_lint = 1
"let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
"let g:pymode_lint_write = 1
" Support virtualenv
let g:pymode_virtualenv = 1
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
let g:pymode_folding = 0
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"
let g:pymode_rope_show_doc_bind = '<leader>d'
let g:pymode_rope_regenerate_on_write = 1
let g:pymode_rope_rename_bind = '<leader>f'
let g:pymode_rope_organize_imports_bind = '<leader>i'
"let g:pymode_rope_autoimport_bind = '<leader>ci'
" disable bunch of annoying things
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport = 0

" Python mode
let g:pymode_doc_key='K'
let g:pymode_breakpoint_key='<leader>b'
let g:pymode_run_bind='<F5>'

" pythonsyntax
let python_highlight_all = 1

" }}}

" Clojure {{{
let g:clojure_syntax_keywords = {
      \ 'clojureMacro': ["defproject", "defcustom"],
      \ 'clojureFunc': ["string/join", "string/replace"]
      \ }

" Scan lines
let g:clojure_maxlines = 100
" }}}

" clang {{{
" ClangFormat, ClangFormatAutoToggle, ClangFormatAutoEnable, ClangFormatAutoDisable
let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -4,
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11"}
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <leader>c :ClangFormatAutoToggle<CR>
autocmd FileType c ClangFormatAutoEnable
" }}}

" LaTex {{{
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []
nmap <silent> dsa ds}dF\

autocmd BufRead *.bib set  noai nocin nosi inde=
" }}}

" =================================
" END of language settings
" =================================
"
" ctrlp ctrlpfunky {{{
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
      \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
      \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
" use ag if possible
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ctrlpfunky
" ctrlp插件1 - 不用ctag进行函数快速跳转
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']
" }}}
" nerdtree nerdtreetabs {{{
" map <leader>n :NERDTreeToggle<CR>
nmap " :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" nerdtreetabs
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" Turn off sync
" let g:nerdtree_tabs_synchronize_view=0
" let g:nerdtree_tabs_synchronize_focus=0
" 是否自动开启nerdtree
" thank to @ListenerRi, see https://github.com/wklken/k-vim/issues/165
" let g:nerdtree_tabs_open_on_console_startup=0
" let g:nerdtree_tabs_open_on_gui_startup=0
" }}}
" tagbar {{{
"nmap <F9> :TagbarToggle<CR>
noremap <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
" let g:tagbar_show_visibility = 1
" for ruby
let g:tagbar_type_ruby = {
      \ 'kinds' : [
      \ 'm:modules',
      \ 'c:classes',
      \ 'd:describes',
      \ 'C:contexts',
      \ 'f:methods',
      \ 'F:singleton methods'
      \ ]
      \ }
" 1. install gotags 'go get -u github.com/jstemmer/gotags'
" 2. make sure `gotags` in you shell PATH, you can call check it with `which gotags`
" for gotags. work with tagbar
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }
nmap <leader>= :TagbarToggle<CR>
let g:tagbar_autofocus = 0

" }}}

" =============================================================================
" Auto commands
" =============================================================================

" helper function
fu Map_ftype(ftypes, cmd)
  for ftype in a:ftypes
    execute 'au Filetype' ftype a:cmd
  endfor
endf

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.pacnew set readonly
autocmd BufRead *.orig set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto-make less files on save
autocmd BufWritePost *.less if filereadable("Makefile") | make | endif

" Follow Rust code style rules
au Filetype rust source ~/.vim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.vim/scripts/closetag.vim

" =============================================================================
" Footer
" =============================================================================

" neocomplete {{{
" ----------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
let g:neocomplete#min_keyword_length = 1
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#data_directory = $HOME.'/.vim/tmp/neocomplete'

" disable the auto select feature by default to speed up writing without
" obstacles (is optimal for certain situations)
let g:neocomplete#enable_auto_select = 0

" toggle the auto select feature
function! ToggleNeoComplete()
  if !g:neocomplete#disable_auto_complete && g:neocomplete#enable_auto_select
    let g:neocomplete#disable_auto_complete = 0
    let g:neocomplete#enable_auto_select = 0
  elseif !g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
    let g:neocomplete#disable_auto_complete = 1
    let g:neocomplete#enable_auto_select = 0
  elseif g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
    let g:neocomplete#disable_auto_complete = 0
    let g:neocomplete#enable_auto_select = 1
  endif
endfunction

nnoremap <silent><Leader>ea :call ToggleNeoComplete()<CR>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.python='[^. \t]\.\w*'
" }}}
"
" vim-surround {{{
let g:surround_42 = "**\r**"
nnoremap ** :exe "norm v$hS*"
nnoremap __ :exe "norm v$hS_"
nmap <leader>** ysiw**
nmap <leader>__ ysid__
nmap <leader>* ysiw*
vmap * S*
vmap _ S_
vmap <leader>l <Plug>VSurround]%a(<C-r><C-p>+)<Esc>
" }}}
"
" Linux Kernel Coding Style {{{
nnoremap <silent> <leader>a :LinuxCodingStyle<cr>
let g:linuxsty_patterns = [ "/kernels" ]
"let g:linuxsty_patterns = [ "~/git/kernels/" ]
" }}}
"
"
"" Neosnippet {{{1
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" More snippet
"
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
" }}}


" ======================
" Syntastic setting
" ======================
" Recommanded setting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0  " no check on open
let g:syntastic_check_on_wq = 1    " check when exit

" Define files to do type checking
let g:syntastic_mode_map = {
      \ "mode": "active",
      \ "passive_filetypes": ["tex", "md"] }

" Python
let g:syntastic_python_checkers=['pyflakes']

" Javascript
let g:syntastic_javascript_checkers = ['jshint']

" Go
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'java'] }

" Tex -- I dont really type checking for latex
"let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
" Custom CoffeeScript SyntasticCheck
func! SyntasticCheckCoffeescript()
  let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
  execute "tabedit " . l:filename
  execute "SyntasticCheck"
  execute "Errors"
endfunc
"nnoremap <silent> <leader>c :call SyntasticCheckCoffeescript()<cr>

function! FindConfig(prefix, what, where)
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction
autocmd FileType javascript let b:syntastic_javascript_jscs_args =
      \ get(g:, 'syntastic_javascript_jscs_args', '') .
      \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))

" ====================
" Temp setup
" ====================
" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

" https://github.com/LucHermitte/local_vimrc
let g:local_vimrc = ['.config', '_vimrc_local.vim']

" vim easytags {{
" http://vim.wikia.com/wiki/Browsing_programs_with_tags
"autocmd FileType python let b:easytags_auto_highlight = 0

" }}

" MIT Scheme
"let g:slimv_swank_cmd = '! screen -d -m -t REPL-SBCL sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp'

" vim-slime {{{
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
" }}}

" Vim niji {{{
let g:niji_dark_colours = [
      \ [ '81', '#5fd7ff'],
      \ [ '99', '#875fff'],
      \ [ '1',  '#dc322f'],
      \ [ '76', '#5fd700'],
      \ [ '3',  '#b58900'],
      \ [ '2',  '#859900'],
      \ [ '6',  '#2aa198'],
      \ [ '4',  '#268bd2'],
      \ ]
" }}}

" tslime {{{
let g:tslime_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<localleader>t'
let g:tslime_visual_mapping = '<localleader>t'
let g:tslime_vars_mapping = '<localleader>T'
" }}}

" Haskell {{{
"
" By far the best solution is vim2hs
"
"au FileType haskell source ~/.vim/lang/haskell.vim
" }}}

" supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" nerdtree
map <Leader>n :NERDTreeToggle<CR>

" tabularize
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
vmap a, :Tabularize /<-<CR>
vmap al :Tabularize /[\[\\|,]<CR>

" CtrlP
map <silent> <Leader>t :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]dist$'
" }}}

" repls {{{
au FileType lisp nnoremap M :!clisp -repl %<cr><cr>
au FileType python nnoremap M :!python -i %<cr><cr>
au FileType scheme nnoremap M :!rlwrap guile -l %<cr><cr>
" }}}
" spell & prose {{{
" RUN: :mkspell! %
set spell
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add
let prose_fts = ['gitcommit', 'mail',  'markdown',  'text' ]
" We want word wrapping for 'prose'. We also want spell check.
au BufRead,BufNewFile /*.md set ft=markdown
call Map_ftype(prose_fts, 'set tw=72 fo=aw2tq spell')
au FileType *.org fo=aw2tq spell
au FileType help set nospell

" }}}
" Writing {{{
func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()
" }}}

" end of vimrc
