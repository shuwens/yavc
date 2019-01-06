" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" ===========================================================================
"  PLUGINS
" ===========================================================================
" Load vundle
set nocompatible
filetype off
set rtp+=~/dev/others/base16/vim/
call plug#begin('~/.local/share/nvim/plugged')

" Load plugins

" VIM enhancements
" ----------------
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
"Plug 'Shougo/unite.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive'
"Plug 'sheerun/vim-polyglot'   " I don't need this and it is buggy
Plug 'tpope/vim-sleuth'  " Heuristically set buffer options
Plug 'tpope/vim-speeddating'
Plug 'ntpeters/vim-better-whitespace' " Remove trailing spaces

" GUI enhancements
" ----------------
Plug 'machakann/vim-highlightedyank'
"Plug 'itchyny/lightline.vim'   " use air line ?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yilin-Yang/vim-markbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'hecal3/vim-leader-guide'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'scrooloose/nerdtree'

" Fuzzy finder
" ------------
Plug 'airblade/vim-rooter'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Semantic language support
" -------------------------
Plug 'w0rp/ale'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

" Completion plugins
" NOTE: I give up on ncm2 because it crashes a lot :(
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'
Plug 'google/vim-codefmt'
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
"Plug 'neomake/neomake'

" VIM editting enhancements
" -------------------------
Plug 'jiangmiao/auto-pairs'
"Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'RRethy/vim-illuminate'
Plug 'inside/vim-search-pulse'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'lilydjwg/colorizer'
"Plug 'terryma/vim-smooth-scroll'

" Syntactic language support
" --------------------------
Plug 'vim-scripts/gnuplot-syntax-highlighting'
" Plug 'treycordova/rustpeg.vim.git'
" Plug 'vim-scripts/haskell.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'jceb/vim-orgmode'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'eagletmt/coqtop-vim'
"Plug 'mattn/webapi-vim'
"Plug 'junegunn/vader.vim'

" Python
Plug 'roxma/python-support.nvim'
Plug 'tweekmonster/impsort.vim'
Plug 'ambv/black'
" Python completions
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
" language specific completions on markdown file
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')
" utils, optional
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
"Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
"Plug 'bennyyip/vim-yapf' "forked from rhysd/vim-clang-format

" Rust
Plug 'rust-lang/rust.vim'

" LaTeX
Plug 'rhysd/vim-grammarous'
"Plug 'reedes/vim-lexical' " No?
"Plug 'lervag/vimtex' " maybe I don't actually need it
"Plug 'LaTeX-Box-Team/LaTeX-Box'

" Color
" -----
"Plug 'rakr/vim-one'
"Plug 'kristijanhusak/vim-hybrid-material'
if !isdirectory("$HOME/dev/others/base16")
	"Plug ' mhartington/oceanic-next'
	Plug 'Soares/base16.nvim'
endif


" Plug '~/dev/projects/simio', {'rtp': 'src/vim-syntax/'}
"Plug '~/dev/projects/api-soup', {'rtp': 'vim-syntax/'} " what is this?
"Plug 'fcangialosi/bootlin.vim' " Linux source code via Elixir's Bootlin

call plug#end()

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()

runtime macros/matchit.vim

if has('nvim')
	set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
	set inccommand=nosplit
	noremap <C-q> :confirm qall<CR>
end

if !has('gui_running')
	set t_Co=256
endif

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
let g:base16_shell_path="$HOME/dev/others/base16/shell/scripts/"

" Lightline (Deprecated) {{{
" let g:lightline = { 'colorscheme': 'wombat' }
"let g:lightline = {
"			\ 'component_function': {
"			\   'filename': 'LightlineFilename',
"			\ },
"			\ }
"function! LightlineFilename()
"	return expand('%:t') !=# '' ? @% : '[No Name]'
"endfunction
" }}}

" Airline
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_atelierdune'
let g:airline#extensions#ale#enabled = 1

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" language server protocol - LSP {{{
"
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_settingsPath = "$HOME/.config/nvim/settings.json"
let g:LanguageClient_autoStart = 1
set omnifunc=LanguageClient#complete
let deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
			\ 'rust': ['$HOME/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
			\ 'javascript': ['javascript-typescript-stdio'],
			\ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
			\ 'python': ['pyls'],
			\ }
" LSP diagnosis
"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
"let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
" }}}
" LSP - keybindings {{{
"
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <leader>m :call LanguageClient_contextMenu()<CR>
nnoremap <leader>k :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> H :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> D :call LanguageClient#textDocument_definition()<CR>
"nnoremap <leader>d :call LanguageClient#textDocument_definition()<cr>
nnoremap <silent> Z :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>] :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> R :call LanguageClient#textDocument_references()<cr>
nnoremap <leader>r :call LanguageClient#textDocument_references()<cr>
nnoremap <silent> N :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>n :call LanguageClient#textDocument_rename()<cr>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> S :call LanugageClient#textDocument_documentSymbol()<CR>
" Emacs style
nnoremap <leader>. :call LanguageClient#textDocument_definition()<CR>
"nnoremap <leader>* :call LanguageClient#textDocument_references()<cr>
nnoremap <leader>s :call LanugageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>o <C-O>
nnoremap <leader>/ <C-O>
" }}}

" Rust {{{
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
"let g:racer_cmd = "/usr/bin/racer"
"let g:racer_experimental_completer = 1

" Follow Rust code style rules
au Filetype rust source $HOME/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" <leader>= reformats current tange
autocmd FileType rust nnoremap <leader>= :'<,'>RustFmtRange<CR>
" }}}

" Golang {{{
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>r <Plug>(go-rename)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/others/r/bin")
let g:go_version_warning = 0
" }}}
"
" Completion
" tab to select, and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Doxygen
let mysyntaxfile='$HOME/.config/nvim/doxygen_load.vim'

" ===========================================================================
"   Editor settings
" ===========================================================================
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=3
set noshowmode
set hidden
set nowrap
set nojoinspaces
if (match($TERM, "-256color") != -1) && (match($TERM, "tmux-256color") == -1)
	" screen does not (yet) support truecolor
	set termguicolors
endif

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

" ==========================================================================
"    GUI settings
" ==========================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set foldmethod=marker " Only fold on marks
set ruler " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=200
set laststatus=2
set relativenumber                 " Relative line numbers
autocmd InsertEnter * :set number  " Now it is hybrid!
autocmd InsertLeave * :set nonumber
set diffopt+=iwhite " No whitespace in vimdiff
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set completeopt-=preview
set shortmess+=c " don't give |ins-completion-menu| messages.

" Colors
set background=dark
colorscheme base16-atelier-dune
"colorscheme atelier-dune
hi Normal ctermbg=NONE

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" ===========================================================================
"   Keyboard shortcuts
" ===========================================================================
" ; as :
nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Suspend with Ctrl+f
"inoremap <C-f> :sus<cr>
"vnoremap <C-f> :sus<cr>
"nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
"map H ^
"map L $
map [ ^
map ] $
nnoremap <C-h> ^
nnoremap <C-l> $

" Neat X clipboard integration linux {{{
"
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
"noremap <leader>p :read !xsel --clipboard --output<cr>
"noremap <leader>c :w !xsel -ib<cr><cr>
" }}}

" fzf !!! {{{
"
"let g:fzf_layout = { 'down': '~20%' }
let g:fzf_layout = { 'down': '~35%' }

" Open hotkeys
nmap <leader>p :Files<CR>
nmap <leader>; :Buffers<CR>
nnoremap <leader>f :GFiles<CR>
nmap <leader>g :GFiles?<CR>
" <leader>s for Rg search
noremap <leader>s :Rg<CR>
noremap <leader>a :Rg<CR>

" fzf helper methods
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
			\ call fzf#vim#grep(
			\   'git grep --line-number '.shellescape(<q-args>), 0,
			\   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
			\ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
			\ call fzf#vim#ag(<q-args>,
			\                 <bang>0 ? fzf#vim#with_preview('up:60%')
			\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
			\                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" TODO(jethros): write a GitFiles method that start fzf in full screen and
" display GFiles
command! -bang -nargs=? GitFiles
			\ call fzf#vim#gitfiles('?',
			\                 <bang>0 ? fzf#vim#with_preview('up:60%')
			\                         : fzf#vim#with_preview('up:60%:hidden', '?'),
			\                 <bang>0)
" }}}

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Jump to next/previous error
"nnoremap <C-j> :cnext<cr>
"nnoremap <C-k> :cprev<cr>

"nnoremap <C-l> :copen<cr>
"nnoremap <C-l> :copen<cr>
nnoremap <C-g> :cclose<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
"noremap <leader>m ct_   " choosing over lsp ctx menu
noremap <leader>n ct-

" M to make
noremap M :!make -k -j4<cr>

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>


" ===========================================================================
"    Autocommands
" ===========================================================================

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

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.xlsx.axlsx set filetype=ruby
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.org set filetype=org

" Script plugins
autocmd Filetype html,xml,xsl,php source $HOME/.config/nvim/scripts/closetag.vim

"  Deprecated keybindings {{{

" yapf - Deprecated becasue it is automatic
"map <C-Y> :call yapf#YAPF()<cr>
"imap <C-Y> <c-o>:call yapf#YAPF()<cr>
"
" map to <Leader>cf in python code
"autocmd FileType python nnoremap <buffer><Leader>cf :<C-u>Yapf<CR>
"autocmd FileType python vnoremap <buffer><Leader>cf :Yapf<CR>
" if you install vim-operator-user
"autocmd FileType python map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
"nmap <Leader>C :YapfAutoToggle<CR>


" Rewrap (Deprecated)
" Rewrap is similar to the gqq command with textwidth, but it also uses a hanging
"   indent and can be used on multiple lines of text.  And note that textwidth needs
"   to be set beforehand.
" Probably generally best to use with the F3 hotkey defined below.  Can use
"   count to determine how many rows below to include.  Cannot use directions.
" Very, very useful for docblocks and if not using a version of Vim with the
"   breakindent patch
"
" From https://github.com/anorman728/vimprojects/blob/master/Rewrap.vim
function! RewrapFunc() range
	let lines = a:lastline-a:firstline+1
	if lines!=1
		let joinlines = lines-1
		exe ":normal ".lines."J"
	endif
	exe ":normal gqq"
	while line('.')!=a:firstline
		exe ":normal I  "
		exe ":normal k"
	endwhile
endfunction
command! -range RewrapCmd <line1>,<line2>call RewrapFunc()
" FIXME: not good
"nmap Q :RewrapCmd<CR>

" ncm2
" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
"set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
"inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
			\ 'name' : 'css',
			\ 'priority': 9,
			\ 'subscope_enable': 1,
			\ 'scope': ['css','scss'],
			\ 'mark': 'css',
			\ 'word_pattern': '[\w\-]+',
			\ 'complete_pattern': ':\s*',
			\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
			\ })


"  }}}

" A second kind of re-wrap {{{
" Reformat lines (getting the spacing correct)
"
" https://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
fun! TeX_fmt()
	if (getline(".") != "")
		let save_cursor = getpos(".")
		let op_wrapscan = &wrapscan
		set nowrapscan
		let par_begin = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
		let par_end   = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
		try
			exe '?'.par_begin.'?+'
		catch /E384/
			1
		endtry
		norm V
		try
			exe '/'.par_end.'/-'
		catch /E385/
			$
		endtry
		norm gq
		let &wrapscan = op_wrapscan
		call setpos('.', save_cursor)
	endif
endfun
" }}}
"autocmd Filetype tex set ts=2 sw=2 et
autocmd Filetype tex nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype markdown nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype org nmap Q :call TeX_fmt()<CR>

" vim spell
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
	if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
		exec 'mkspell! ' . fnameescape(d)
	endif
endfor

" ===========================================================================
"   Personal config
" ===========================================================================

set shortmess=at
set cmdheight=2
set tw=79
set cursorline
set cursorcolumn
"hi CursorLine   cterm=NONE ctermbg=232 guibg=#050505
"hi CursorColumn cterm=NONE ctermbg=232 guibg=#050505
hi Folded ctermbg=234 ctermfg=red

" Linter -- ALE {{{
highlight ALEErrorSign ctermfg=9
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" lint should be handled by LSP, but seems like that Rust is bit broken
let g:ale_linters = {
			\ 'LaTeX': ['proselint',],
			\ 'rust': ['rls','cargo',],
			\ }
let g:ale_fixers = {
			\ '*': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'rust': ['rustfmt']
			\ }
let g:ale_sign_column_always = 1
" only lint when I want
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 1
" format error msg
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Rust
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_rust_cargo_use_check = 1 
let g:ale_rust_cargo_check_all_targets = 1

" ALE bindings
"nmap <silent> L <Plug>(ale_lint)
"nnoremap <leader>l <Plug>(ale_lint)
nnoremap <leader>l :ALELint<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-]> <Plug>(ale_previous_wrap)
nmap <silent> <C-[> <Plug>(ale_next_wrap)
" }}}

" vim-grammarous {{{

"let g:grammarous#use_vim_spelllang = 0
"let g:grammarous#enable_spell_check = 1

let g:grammarous#disabled_rules = {
			\ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
			\ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
			\ }
" TODO: imrpovement for LaTeX files

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
	nmap <buffer><C-i> <Plug>(grammarous-move-to-info-window)
	nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
	nmap <buffer><C-P> <Plug>(grammarous-move-to-previous-error)
	nmap <buffer><leader>f <Plug>(grammarous-fixit)
	nnoremap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
	nunmap <buffer><C-n>
	nunmap <buffer><C-p>
	nunmap <buffer><leader>f
endfunction

"nnoremap <buffer> ]g <Plug>(grammarous-move-to-next-error)
"nnoremap <buffer> [g <Plug>(grammarous-move-to-previous-error)
nnoremap <leader>L :GrammarousCheck --lang=en-US --preview<CR>
nnoremap <leader>G :GrammarousCheck --lang=en-US --preview<CR>
" }}}

" LaTeX {{{
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

" polyglot for LaTeX
"let g:polyglot_disabled = ['latex']
" }}}

" Python is special {{{
" NOTE: I only want to auto-format Python files that belong to me
let g:black_linelength = 80
autocmd BufRead,BufNewFile $HOME/dev/projects/** let b:DevPythonFile=1
autocmd BufWritePre *.py call DevPythonFormatter()
fun! DevPythonFormatter()
	if !exists('b:DevPythonFile')
		return
	endif
	" I use black, not autopep8 or yapf for now... I wonder the best practise
	execute ':Black'
	ImpSort!
	call DeleteTrailingWS()
endfun
" }}}
"
" Google codefmt {{{
augroup autoformat_settings
	autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
	autocmd FileType go AutoFormatBuffer gofmt
	"autocmd FileType rust AutoFormatBuffer rustfmt +nightly
	" ===================
	autocmd FileType bzl AutoFormatBuffer buildifier
	autocmd FileType html,css,json AutoFormatBuffer js-beautify
	autocmd FileType java AutoFormatBuffer google-java-format
augroup END

" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Mac setting, not important {{{
"
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif
" }}}

" better whitespace
" red #FF0000, coral #FF7F50, tomato #FF6347, orangered #FF4500, orange
" #FFA500, darkorange #FF8C00
"let g:better_whitespace_ctermcolor='<desired_color>'
let g:better_whitespace_guicolor='#FF4500'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" ===========================================================================
"   Personal Keybindings
" ===========================================================================

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Quick-save
nmap <leader>w :StripWhitespace<CR>:w<CR>
nmap <leader>wq :wq<CR>
"nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>qq :q!<Esc>:q!<CR>
command! W w
command! Wq wq
command! WQ wq

" detele things shortcut
nnoremap <C-i> C
"inoremap <C-i> C
vnoremap <C-i> C
nnoremap <leader>i C
"inoremap <leader>i C
vnoremap <leader>i C



" Type lang<C-Y> for shebang line
nnoremap <C-y> <Esc>:sil exe ".!which <cWORD>" <bar> s/^/#!/ <bar> filetype detect<cr>YpDi

" indent line
let g:indent_guides_enable_on_vim_startup = 1

" map wincmd {{{
"
" The right windcmd
nmap <silent>J :wincmd j<CR>
nmap <silent>K :wincmd k<CR>
nmap <silent>H :wincmd h<CR>
nmap <silent>L :wincmd l<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" using ctrl hj"
"nmap <leader>j :wincmd j<CR>
"nmap <leader>k :wincmd k<CR>
"nmap <leader>h :wincmd h<CR>
"nmap <leader>l :wincmd l<CR>
"}}}

" provide hjkl movements in Insert mode via the <Alt> modifier key  {{{
"
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
" }}}

" C++ reference look up  {{{
" https://stackoverflow.com/questions/2272759/looking-up-c-documentation-inside-of-vim?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}

" vim markbar {{{
map <Leader>mm <Plug>ToggleMarkbar
" the following are unneeded if ToggleMarkbar is mapped
map <Leader>mo <Plug>OpenMarkbar
map <Leader>mc <Plug>CloseMarkbar

" only display alphabetic marks a-i and A-I
"let g:markbar_marks_to_display = 'abcdefghiABCDEFGHI'

" width of a vertical split markbar
let g:markbar_width = 75

" indentation for lines of context
let g:markbar_context_indent_block = '  '

" number of lines of context to retrieve per mark
let g:markbar_num_lines_context = 3

" markbar-local mappings
let g:markbar_jump_to_mark_mapping  = 'G'
let g:markbar_next_mark_mapping     = '/'
let g:markbar_previous_mark_mapping = '?'
let g:markbar_rename_mark_mapping   = '<F2>'
let g:markbar_reset_mark_mapping    = 'r'
let g:markbar_delete_mark_mapping   = '<Del>'

" file mark
let g:markbar_file_mark_format_string = '%s [line: %2d, col: %2d]'
let g:markbar_file_mark_arguments = ['fname', 'line', 'col']
" }}}

" fugitive {{{
"
nnoremap <silent> gd :GDiff<CR>
nnoremap <silent> dg :diffget<CR>
" }}}

" vim lexical {{{
augroup lexical
	autocmd!
	"autocmd FileType markdown,mkd call lexical#init()
	"autocmd FileType textile call lexical#init()
	"autocmd FileType tex call lexical#init()
	"autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
"let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt',]
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add',]
let g:lexical#spelllang = ['en_us',]
" }}}


"--- Try
" vim-illuminate
hi link illuminatedWord Visual
" Time in milliseconds (default 250)
let g:Illuminate_delay = 1500
"let g:Illuminate_ftHighlightGroups = {
"      \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
"      \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
"      \ }

" vim-search-pulse
let g:vim_search_pulse_duration = 200

" semshi
let g:deoplete#auto_complete_delay = 100

" nerdtree ot something
let g:NERDTreeWinPos = "right"
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" org mode
"let g:polyglot_disabled = ['org']

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif
