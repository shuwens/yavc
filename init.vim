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
call plug#begin('$HOME/.local/share/nvim/plugged')

" Load plugins

" VIM enhancements
" ----------------
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive'
"Plug 'sheerun/vim-polyglot'   " I don't need this and it is buggy
Plug 'tpope/vim-sleuth'  " Heuristically set buffer options
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-speeddating'
Plug 'mbbill/undotree'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'yaahallo/rscmake', { 'do': './install.sh' }

" GUI enhancements
" ----------------
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'Yggdroot/indentLine'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'bounceme/poppy.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Fuzzy finder
" ------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'
if !empty(glob("/usr/local/opt/fzf"))
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
endif

" Semantic language support
" -------------------------

" Completion plugins
" COC
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}"
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

" VIM editing enhancements
" -------------------------
Plug 'jiangmiao/auto-pairs'
"Plug 'luochen1990/rainbow', { 'branch': 'develop' }
Plug 'RRethy/vim-illuminate'
Plug 'inside/vim-search-pulse'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'lilydjwg/colorizer'
Plug 'junegunn/vader.vim'

" Syntactic language support
" --------------------------
Plug 'vim-scripts/gnuplot-syntax-highlighting'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'jceb/vim-orgmode'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'arakashic/chromatica.nvim'

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

" Rust
Plug 'rust-lang/rust.vim'

" LaTeX
Plug 'rhysd/vim-grammarous'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Color
if !isdirectory("$HOME/dev/others/base16")
  "Plug ' mhartington/oceanic-next'
  Plug 'chriskempson/base16-vim'
endif
Plug 'nightsense/cosmic_latte'
call plug#end()

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


" }}}
" echodoc {{{
let g:echodoc_enable_at_startup = 1
" }}}

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" Javascript
let javaScript_fold=0

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
" Rust {{{
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
"let g:rust_keep_autopairs_default = 1
"let g:rust_clip_command = 'xclip -selection clipboard'
" <leader>= reformats current tange
"autocmd FileType rust nnoremap <leader>= :'<,'>RustFmtRange<CR>
autocmd FileType rust nnoremap <leader>= :RustFmt<CR>
" }}}

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
if (match($TERM, "-256color") != -1) && (match($TERM, "tmux-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
" for the vagrant linux box
if (match($TERM, "xterm") != -1)
  set termguicolors
endif
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
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

" Use regular tabs (wide)
set shiftwidth=4
set softtabstop=4
set tabstop=4
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
"set shortmess=at
set completeopt-=preview

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
"colorscheme cosmic_latte

hi Normal guibg=NONE
highlight nonText guibg=NONE
hi Normal ctermbg=NONE
hi Folded ctermbg=234 ctermfg=red

" sensible: no need now{{{
"set scrolloff=3
"runtime macros/matchit.vim
" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
"set nolist
"set listchars=nbsp:¬,extends:»,precedes:«,trail:•
" }}}

" Jump to last edit position on opening file
" https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

" Jump to start and end of line using the home row keys {{{
"map H ^
"map L $
map [ ^
map ] $
nnoremap <C-l> ^
nnoremap <C-h> $
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I
nnoremap <C-e> <Esc>A
nnoremap <C-a> <Esc>I
" }}}

" Neat X clipboard integration linux {{{
"
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
if has('unix')
  if has('mac')       " osx
    " Paste clipboard content to current line
    noremap <leader>p :r !pbpaste<CR>
    noremap <leader>c :w !pbcopy<CR><CR>
  else                " linux, bsd, etc
    noremap <leader>p :read !xsel --clipboard --output<cr>
    noremap <leader>c :w !xsel -ib<cr><cr>
  endif
endif
" }}}
"
" fzf !!! {{{
" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"
"let g:fzf_layout = { 'down': '~20%' }
let g:fzf_layout = { 'down': '~35%' }
" Keybindings
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <leader>c :Commits<CR>
" Open hotkeys
nnoremap <leader>p :Files<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>g :GFiles?<CR>
" <leader>s for Rg search
noremap <leader>s :Rg<CR>
noremap <leader>a :Ag<CR>
noremap <leader>rg :Rgg<CR>
" }}}
" fzf helper methods {{{

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

command! -bang -nargs=* Rgg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
      \ 'options': '--tiebreak=index'}, <bang>0)

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
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

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
"   Personal Keybindings
" ===========================================================================

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Quick-save
nmap <leader>w :StripWhitespace<CR>:w<CR>
nmap <leader>wq :wq<CR>
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

" F3 to insert a logical clock
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
inoremap <special> <F3> <c-r>=strftime('%c')<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Replaced gundo with UndoTree, pure vimscript instead of dependencies
nnoremap <leader>u :UndotreeToggle<CR>

" vim-dispatch
nnoremap <leader>d :Dispatch<CR>
" special case for netbricks
autocmd BufRead,BufNewFile $HOME/dev/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/netbricks/** nnoremap <leader>d :Dispatch!<CR>

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

" rainbow parentheses {{{
"
" }}}

" VIM spell
set spelllang=en_us
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

" ===========================================================================
"   Personal config
" ===========================================================================
" vim-grammarous {{{

let g:grammarous#disabled_rules = {
      \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
      \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
      \ }

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
  nmap <buffer><C-i> <Plug>(grammarous-move-to-info-window)
  nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
  nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
  nmap <buffer><leader>f <Plug>(grammarous-fixit)
  nnoremap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
  nunmap <buffer><C-j>
  nunmap <buffer><C-k>
  nunmap <buffer><leader>f
endfunction

nnoremap <leader>L :GrammarousCheck --lang=en-US --preview<CR>
nnoremap <leader>G :GrammarousCheck --lang=en-US --preview<CR>
" }}}

" LaTeX {{{
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []
let g:tex_conceal = ""
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'
autocmd BufNewFile,BufRead *.tex set syntax=context
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" highlighted yank
if !exists('##textyankpost')
  map y <plug>(highlightedyank)
endif

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

" Delete trailing white space on save, useful for Python and CoffeeScript ;) {{{
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" }}}

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
" fugitive {{{
"
nnoremap <silent> gd :GDiff<CR>
nnoremap <silent> dg :diffget<CR>
" }}}

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

" gitgutter
let g:gitgutter_enabled = 0

" NERDCommenter {{{
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
      \ 'c': {'left': '//'},
      \ 'cpp': {'left': '//'},
      \ 'python': {'left': '#'},
      \ 'rust': {'left': '//'},
      \ }
" Nerd commenter keybindings
"map <leader>\ <leader>c<Space>
map <leader>cc <plug>NERDComToggleComment
map <C-\> <leader>c<Space>
" }}}

" Preview
let g:livepreview_previewer = 'open -a Preview'

" poppy
au! cursormoved * call PoppyInit()

" auto pair jump
let g:AutoPairsShortcutJump = '<leader>\'
"let g:AutoPairsShortcutJump = '<S-tab>'
" let g:AutoPairsShortcutJump = '<C-l>'
"let g:AutoPairsShortcutJump = '<M-n>'

" chromatica
let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1

source $HOME/.config/nvim/coc.vim

set hidden
" nvim
if has('nvim')
  runtime! plugin/python_setup.vim
endif
