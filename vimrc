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
" change to https://github.com/ctrlpvim/ctrlp.vim
" ctrlp ctrlpfunky
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'

" rainbow_parentheses
Plug 'kien/rainbow_parentheses.vim'

" Semantic language support
Plug 'Raimondi/delimitMate'
Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'

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
Plug 'dag/vim-fish'
Plug 'vivien/vim-linux-coding-style'
Plug 'rhysd/vim-clang-format'
Plug 'szw/vim-tags'

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
"let g:neomake_verbose = 0
"let g:neomake_tex_proselint_maker = {
"			\ 'errorformat': '%f:%l:%c: %m'
""			\ }
"let g:neomake_tex_enabled_makers = ['chktex', 'lacheck', 'proselint']
"let g:neomake_rust_enabled_makers = []
"let g:neomake_info_sign = {'text': '⚕', 'texthl': 'NeomakeInfoSign'}
":autocmd! BufWritePost * Neomake
"autocmd BufWritePost *.rs Neomake! cargo
"autocmd BufWritePost *.rs Neomake! clippy
"nnoremap <C-g> :Neomake!<CR>
"inoremap <C-g> :Neomake!<CR>

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" Per-buffer CtrlP hotkey
nmap <leader>; :CtrlPBuffer<CR>
nmap <leader>o :CtrlP<CR>
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
"nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>qq :q!<Esc>:q!<CR>

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

" ====================================
" # Golang
" ====================================
" vim-go {{{
let g:go_play_open_browser = 0
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
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 1
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'java'] }
" }}}

" ===================================
" # Python-mode
" ===================================
" python-mode {{{
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
" }}}

" Don't gofmt Biscuit (yet)
"autocmd BufRead,BufNewFile /home/jon/dev/others/biscuit/** let [g:go_fmt_command, g:go_fmt_autosave]=["", 0]

" =============================================================================
" # Editor settings
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
set ttyfast
set lazyredraw
set laststatus=2
set relativenumber " Relative line numbers
set diffopt+=iwhite " No whitespace in vimdiff
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
"set completeopt-=preview
set completeopt=longest,menu

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
"inoremap <C-j> <Esc>
"vnoremap <C-j> <Esc>
"inoremap <C-c> <Esc>
"vnoremap <C-c> <Esc>

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
noremap <F1> <Esc>"
imap <F1> <Esc>

" ctrlp ctrlpfunky {{{
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
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
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" nerdtreetabs
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
nmap <F9> :TagbarToggle<CR>
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
" }}}

" pythonsyntax {{{
let python_highlight_all = 1
" }}}

" =============================================================================
" # Autocommands
" =============================================================================

" delimitMate {{{
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType go,python,c,cpp let delimitMate_matchpairs = "(:),[:],{:}"
"au FileType mail let b:delimitMate_autoclose = 0
" }}}

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

" map wincmd {{{
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" using ctrl hj"
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>h :wincmd h<CR>
nmap <leader>l :wincmd l<CR>

" " DEPRECATED {{{
function! HideNumber()
	if(&relativenumber == &number)
		set relativenumber! number!
	elseif(&number)
		set number!
	else
		set relativenumber!
	endif
	set number?
endfunc
"nnoremap <F2> :call HideNumber()<CR>
" Add highlighting to TODO,NOTE,etc {{{
if has("autocmd")
	" Highlight TODO, FIXME, NOTE, etc.
	if v:version > 701
		autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
		autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
	endif
endif
" vim-surround {{{2
let g:surround_42 = "**\r**"
nnoremap ** :exe "norm v$hS*"
nnoremap __ :exe "norm v$hS_"
nmap <leader>** ysiw**
nmap <leader>__ ysid__
nmap <leader>* ysiw*
vmap * S*
vmap _ S_
vmap <leader>l <Plug>VSurround]%a(<C-r><C-p>+)<Esc>

"cnoremap <leader>j <t_kd>
"cnoremap <C-k> <t_ku>
"cnoremap <leader>a <Home>
"cnoremap <leader>e <End>

" Linux Kernel Coding Style {{{
nnoremap <silent> <leader>a :LinuxCodingStyle<cr>
"let g:linuxsty_patterns = [ "~/git/kernels/" ]

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

" end of vimrc
