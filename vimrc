" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
set nocompatible
filetype off
set rtp+=~/dev/others/base16/builder/templates/vim/
call plug#begin('~/.vim/plugged')

" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'Shougo/neocomplete.vim'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'

" Semantic language support
Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'

" for neovim and is disabled
"Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"if has('python3')
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"endif

" Syntactic language support
" Plugin '~/dev/projects/simio', {'rtp': 'src/vim-syntax/'}
Plug '~/dev/projects/api-soup', {'rtp': 'vim-syntax/'}
Plug 'vim-scripts/gnuplot-syntax-highlighting'
"Plug 'treycordova/rustpeg.vim.git'
Plug 'vim-scripts/haskell.vim'
Plug 'cespare/vim-toml'
Plug 'lervag/vim-latex'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'   " for golang
Plug 'klen/python-mode'   " for python
" install jedi-vim and let g:pymode_rope = 1
"Plug 'dag/vim-fish'

call plug#end()

" Plugin settings
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

" Base16
let base16colorspace=256
"let g:base16_shell_path="~/dev/others/base16/builder/templates/shell/scripts/"

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
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_enable_highlighting = 0
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_sh_shellcheck_post_args = "-x"  " allow sourcing external files
let g:neomake_verbose = 0
let g:neomake_tex_proselint_maker = {
	\ 'errorformat': '%f:%l:%c: %m'
	\ }
let g:neomake_tex_enabled_makers = ['chktex', 'lacheck', 'proselint']
let g:neomake_rust_enabled_makers = []
let g:neomake_info_sign = {'text': '⚕', 'texthl': 'NeomakeInfoSign'}
autocmd! BufWritePost * Neomake
autocmd BufWritePost *.rs Neomake! cargo
"autocmd BufWritePost *.rs Neomake! clippy
nnoremap <C-g> :Neomake!<CR>
inoremap <C-g> :Neomake!<CR>

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" Per-buffer CtrlP hotkey
nmap <leader>; :CtrlPBuffer<CR>
nmap <leader>o :CtrlP<CR>
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" language server protocol
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rustup', 'run', 'nightly', 'cargo', 'run', '--release', '--manifest-path=/home/jon/dev/others/rls/Cargo.toml'],
"    \ }
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" racer + rust
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 1
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

" Completion
"let g:deoplete#enable_at_startup = 1
"inoremap <silent><expr> <TAB>
"		\ pumvisible() ? "\<C-n>" :
"		\ <SID>check_back_space() ? "\<TAB>" :
"		\ deoplete#mappings#manual_complete()
	"	function! s:check_back_space() abort "{{{
	"	let col = col('.') - 1
"		return !col || getline('.')[col - 1]  =~ '\s'
"		endfunction"}}}

" Doxygen
let mysyntaxfile='~/.vim/doxygen_load.vim'

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
<<<<<<< HEAD
let g:go_bin_path = expand("/usr/local/go/bin")
=======
>>>>>>> 46963d4... oops!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
<<<<<<< HEAD
"au FileType go nmap <Leader>gD <Plug>(go-doc-vertical)
"au FileType go nmap <Leader>gDB <Plug>(go-doc-browser)
"au FileType go nmap <Leader>gR <Plug>(go-run)
au FileType go nmap <Leader>gv <Plug>(go-build)


" Python-mode
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
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

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
=======
au FileType go nmap <leader>gD <Plug>(go-doc-vertical)
au FileType go nmap <leader>gDB <Plug>(go-doc-browser)
au FileType go nmap <leader>gR <Plug>(go-run)
au FileType go nmap <leader>gv <Plug>(go-build)
au FileType go nmap <leader>gT <Plug>(go-test)
au FileType go nmap <C-i> :GoDef<cr>
au Filetype go nmap <C-j> :GoDecls<cr>
>>>>>>> 46963d4... oops!


" Don't gofmt Biscuit (yet)
autocmd BufRead,BufNewFile /home/jon/dev/others/biscuit/** let [g:go_fmt_command, g:go_fmt_autosave]=["", 0]

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set nowrap
set nojoinspaces
set termguicolors

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
nnoremap <silent> * *zz
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
set ttyfast
set lazyredraw
set laststatus=2
set relativenumber " Relative line numbers
set diffopt+=iwhite " No whitespace in vimdiff
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set completeopt-=preview

" Colors
set background=dark
colorscheme base16-atelier-dune
hi Normal ctermbg=NONE

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Ack/Ag search
noremap <leader>s :Ag

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
"nnoremap <left> :bp<CR>
"nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Jump to next/previous error
nnoremap <C-j> :cn<cr>
nnoremap <C-k> :cp<cr>
nnoremap <C-l> :copen<cr>
nnoremap <C-h> :cclose<cr>

" ,, toggles between buffers
nnoremap <leader><leader> <c-^>

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
map <F1> <Esc>
imap <F1> <Esc>


" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

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
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif


" Neocomplete portion
"
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:acp_completeoptPreview = 1
setlocal omnifunc=gocode#Complete
