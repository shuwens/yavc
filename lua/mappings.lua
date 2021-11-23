local api = vim.api
local g = vim.g
local cmd = vim.cmd

cmd [[
" Remap VIM 0 to first non-blank character
map 0 ^
" Jump to start and end of line using the home row key
"map H ^
"map L $
map <C-h> <ESC>^
imap <C-h> <ESC>I
map <C-l> <ESC>$
imap <C-l> <ESC>A
nnoremap <C-h> ^
nnoremap <C-l> $

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

command! W w
command! Wq wq
command! WQ wq

" These are all terminal shorthands
" I've made them to recognize common typos
" cnoreabbrev wq w<bar>bd
" cnoreabbrev Wq w<bar>bd
" cnoreabbrev WQ w<bar>bd
cnoreabbrev wqa1 wqa!
cnoreabbrev qa1 qa!
cnoreabbrev Qa qa
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev B buffer

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" highlighted yank
if !exists('##textyankpost')
   map y <plug>(highlightedyank)
endif

" https://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
]]

-- Neat X clipboard integration linux
if vim.fn.has("mac") == 1 then
  -- Paste clipboard content to current line
  api.nvim_set_keymap('v', g.mapleader..'Y', ':w !pbcopy<CR><CR>', { noremap = true, silent = true })
  api.nvim_set_keymap('n', g.mapleader..'P', ':r !pbpaste<CR>', { noremap = true, silent = true })
elseif vim.fn.has("unix") == 1 then
  api.nvim_set_keymap('v', g.mapleader..'Y', ':w !xsel -ib<CR><CR>', { noremap = true, silent = true })
  api.nvim_set_keymap('n', g.mapleader..'P', ':read !xsel --clipboard --output<CR>', { noremap = true, silent = true })
else
  print("Unsupported system!")
end
api.nvim_set_keymap('v', '<C-c>', '"*y', { noremap = true, silent = true })

-- Undo tree
api.nvim_set_keymap('n', g.mapleader..'u', ':UndotreeToggle<CR>', { noremap = true, silent = false })

-- " Nerd Tree
-- let g:NERDTreeWinPos = "right"
-- map <leader>n :NERDTreeToggle<CR>

-- find merge conflict markers
-- api.nvim_set_keymap('n', g.mapleader..'mc', '<ESC>/\v^[<=>]{7}( .*\|$)<CR>', { noremap = true, silent = true })

-- nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
api.nvim_set_keymap('n', g.mapleader..'\\', ':call ToggleList("Quickfix List", "c")<CR>', { noremap = true, silent = true })

-- Open new file adjacent to current file
api.nvim_set_keymap('n', g.mapleader..'e', ':e <C-R>=expand("%:p:h") . "/" <CR>', { noremap = true, silent = false })

-- <leader><leader> toggles between buffers
api.nvim_set_keymap('n', g.mapleader..g.mapleader, '<c-^>', { noremap = true, silent = false })

-- <leader>q shows stats
api.nvim_set_keymap('n', g.mapleader..'Q', 'g<c-g>', { noremap = true, silent = false })

-- <leader>, shows/hides hidden characters
-- nnoremap <leader>, :set invlist<cr>

-- Keymap for replacing up to next _ or -
api.nvim_set_keymap('n', g.mapleader..'m', 'ct_', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'n', 'ct-', { noremap = true, silent = false })

-- Quick-save
api.nvim_set_keymap('n', g.mapleader..'w', ':StripWhitespace<CR>:w<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'wq', ':wq<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'q', ':q!<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'qq', ':q!<Esc>:q!<CR>', { noremap = true, silent = false })

-- Open hotkeys
api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'p', ':Files<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', 'F', ':Files<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..';', ':Buffers<CR>', { noremap = true, silent = false })

-- detele things shortcut
api.nvim_set_keymap('n', '<C-i>', 'C', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'i', 'C', { noremap = true, silent = false })

-- Fugitive Conflict Resolution
-- nnoremap <leader>gd :Gvdiff<CR>
-- nnoremap gdh :diffget //2<CR>
-- nnoremap gdl :diffget //3<CR>

-- " Replaced gundo with UndoTree, pure vimscript instead of dependencies
-- nnoremap <leader>u :UndotreeToggle<CR>

-- Grammar check
api.nvim_set_keymap('n', g.mapleader..'L', ':GrammarousCheck --lang=en-US --preview<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader..'G', ':GrammarousCheck --lang=en-US --preview<CR>', { noremap = true, silent = false })

-- vim-dispatch
api.nvim_set_keymap('n', g.mapleader..'d', ':Dispatch<CR>', { noremap = true, silent = false })
-- FIXME: special case for netbricks
cmd [[
autocmd BufRead,BufNewFile $HOME/dev/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/projects/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/achtung/nfv/** let b:dispatch = 'make clean; make'
autocmd BufRead,BufNewFile $HOME/writings/blogs/** let b:dispatch = 'zola build'
]]
-- nnoremap <leader>c :Commits<CR>

-- ; as :
api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = false })

-- inoremap jh <Esc>
-- inoremap jj <Esc>
-- inoremap jk <Esc>
-- nnoremap Y y$
-- nnoremap gUiw mzgUiw`z
-- nnoremap guiw mzguiw`z

-- No arrow keys: force yourself to use the home row
api.nvim_set_keymap('n', '<Up>', '<nop>', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<Down>', '<nop>', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<Left>', ':bp<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<Right>', ':bn<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('n', 'q', '<nop>', { noremap = true, silent = false })
-- FIXME: Left and right can switch buffers
-- nnoremap <C-N> :bn<CR>
-- nnoremap <C-P> :bp<CR>
-- nnoremap <Tab> :bn<CR>
-- nnoremap <S-Tab> :bp<CR>

-- Move by line
api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = false })
api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = false })

-- M to make
-- " noremap M :!make -k -j4<cr>

-- I can type :help on my own, thanks.
api.nvim_set_keymap('n', '<F1>', '<Esc>', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<F1>', '<Esc>', { noremap = true, silent = false })

-- Visual mode pressing * or # searches for the current selection
api.nvim_set_keymap('v', '*', ':call VisualSelection("f")<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('v', '#', ':call VisualSelection("b")<CR>', { noremap = true, silent = true })

-- F3 to insert a logical clock
api.nvim_set_keymap('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<F3>', '<c-r>=strftime("%c")<CR>', { noremap = true, silent = false })

-- Jump to start and end of line using the home row key
api.nvim_set_keymap('n', '<C-h>', '<ESC>^', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<C-h>', '<ESC>I', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<C-l>', '<ESC>$', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<C-l>', '<ESC>A', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<C-h>', '^', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<C-l>', '$', { noremap = true, silent = false })

-- map wincmd
api.nvim_set_keymap('n', 'J', ':wincmd j<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'K', ':wincmd k<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'H', ':wincmd h<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'L', ':wincmd l<CR>', { noremap = true, silent = true })

-- " resize current split by +/- 5
-- nnoremap <silent> + :exe "vertical resize +5"<CR>
-- nnoremap <silent> - :exe "vertical resize -5"<CR>
-- nnoremap <silent> <leader>] :exe "resize +5"<CR>
-- nnoremap <silent> <leader>[ :exe "resize -5"<CR>

-- Search results centered please
api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true, silent = false })
api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true, silent = false })
api.nvim_set_keymap('n', '*', '*zz', { noremap = true, silent = false })
api.nvim_set_keymap('n', '#', '#zz', { noremap = true, silent = false })
api.nvim_set_keymap('n', 'g*', 'g*zz', { noremap = true, silent = false})


-- Telescope
-- Fuzzy file finder
api.nvim_set_keymap('n', g.mapleader..'ff', ':Telescope find_files hidden=true<CR>', { noremap = true, silent = true })
-- Fuzzy buffer finder
api.nvim_set_keymap('n', g.mapleader..'fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
-- Fuzzy help-tages finder
api.nvim_set_keymap('n', g.mapleader..'fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
-- Search with ripgrep
api.nvim_set_keymap('n', g.mapleader..'fi', ':Telescope live_grep<CR>', { noremap = true, silent = true })
-- Fuzzy git status
api.nvim_set_keymap('n', g.mapleader..'fg', ':Telescope git_status<CR>', { noremap = true, silent = true })
-- Fuzzy old-files finder
api.nvim_set_keymap('n', g.mapleader..'fo', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
-- Fuzzy command finder
api.nvim_set_keymap('n', g.mapleader..'fc', ':Telescope commands<CR>', { noremap = true, silent = true })
-- Fuzzy current file word finder
api.nvim_set_keymap('n', g.mapleader..'fz', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
-- Fuzzy workspace symbols
api.nvim_set_keymap('n', g.mapleader..'fs', ':Telescope lsp_workspace_symbols<CR>', { noremap = true, silent = true })
-- Search projects (projects.nvim)
api.nvim_set_keymap('n', g.mapleader..'fp', ':Telescope projects<CR>', { noremap = true, silent = true })

-- Symbols Finder
api.nvim_set_keymap('n', 'gh', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', { noremap = true, silent = true })
-- Show hovering documentation
api.nvim_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', { noremap = true, silent = true })
-- Scroll down in lspsaga menus
api.nvim_set_keymap('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { noremap = true, silent = true })
-- Scroll up in lspsaga menus
api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { noremap = true, silent = true })
-- Show signature help(imo not thaat useful)
api.nvim_set_keymap('n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', { noremap = true, silent = true })
-- Rename symbols
api.nvim_set_keymap('n', 'gr', '<cmd>lua require("lspsaga.rename").rename()<CR>', { noremap = true, silent = true })
-- Preview definition
api.nvim_set_keymap('n', 'gd', '<cmd>lua require("lspsaga.provider").preview_definition()<CR>', { noremap = true, silent = true })
-- Show suggestions/errors/warnings for the line
api.nvim_set_keymap('n', g.mapleader..'cd', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', g.mapleader..'cc', '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<CR>', { noremap = true, silent = true })

-- Jump to definition
api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Toggle error menu
api.nvim_set_keymap('n', g.mapleader..'h', ':TroubleToggle<CR>', { noremap = true, silent = true })

-- Show symbols outline
api.nvim_set_keymap('n', g.mapleader..'so', ':Vista nvim_lsp<CR>', { noremap = true, silent = true })
-- Show blame for line
api.nvim_set_keymap('n', g.mapleader..'bb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true, silent = true })

-- Call nvim-tree lazy load function
api.nvim_set_keymap('n', '<F3', ':call ToggleNvimTree()<CR>', { noremap = true, silent = true })

-- Open lazygit
api.nvim_set_keymap('n', g.mapleader..'lg', ':LazyGit<CR>', { noremap = true, silent = true })

api.nvim_set_keymap('n', g.mapleader..'gb', ':BufferLinePick<CR>', { noremap = true, silent = true })

-- " Mac setting, not important
-- "
-- " Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
-- nmap <M-j> mz:m+<cr>`z
-- nmap <M-k> mz:m-2<cr>`z
-- vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
-- vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

-- if has("mac") || has("macunix")
--    nmap <D-j> <M-j>
--    nmap <D-k> <M-k>
--    vmap <D-j> <M-j>
--    vmap <D-k> <M-k>
-- endif
-- " C++ reference look up
-- " https://stackoverflow.com/questions/2272759/looking-up-c-documentation-inside-of-vim?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
-- command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
-- autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
-- " fugitive
-- nnoremap <silent> gd :GDiff<CR>
-- nnoremap <silent> dg :diffget<CR>

-- " notational-fzf-vim
-- if !empty(glob("~/notes"))
--    let g:nv_search_paths = ['~/notes']
--    nnoremap NN :NV<CR>
-- endif

-- " NnoreF and Preview are only for macOS
-- if has("mac") || has("macunix")
--    " Preview
--    let g:livepreview_previewer = 'open -a Preview'
-- endif

-- " Easy Align
-- " Start interactive EasyAlign in visual mode (e.g. vipga)
-- xmap ga <Plug>(EasyAlign)
-- " Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- nmap ga <Plug>(EasyAlign)


cmd [[
" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
   exe "normal mz"
   %s/\s\+$//ge
   exe "normal `z"
endfunc

" A second kind of re-wrap
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
autocmd Filetype markdown nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype tex nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype org nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype jemdoc nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype text nmap Q :call TeX_fmt()<CR>zz

" vim-grammarous
let g:grammarous#disabled_rules = {
	 \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
	 \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
	 \ }

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
   nmap <buffer><C-i> <Plug>(grammarous-move-to-info-window)
   nmap <buffer><C-j> <Plug>(grammarous-move-to-next-error)
   nmap <buffer><C-k> <Plug>(grammarous-move-to-previous-error)
   nmap <buffer><leader>f <Plug>(grammarous-fixit)
   nmap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
   nunmap <buffer><C-j>
   nunmap <buffer><C-k>
   nunmap <buffer><leader>f
endfunction

" NERDCommenter
"
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
	 \ 'c': { 'left': '/**','right': '*/' },
	 \ 'cpp': {'left': '//'},
	 \ 'python': {'left': '#'},
	 \ 'rust': {'left': '//'},
	 \ }

" Better commit window
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
   " Additional settings
   setlocal spell

   " If no commit message, start with insert mode
   if a:info.vcs ==# 'git' && getline(1) ==# ''
      startinsert
   endif

   " Scroll the diff window from insert mode
   " Map <C-n> and <C-p>
   imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
   imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

function! ToggleNvimTree()
   if exists(":NvimTreeToggle") == 0
      " lazy load nvim-tree
      silent! packadd nvim-tree.lua
   endif

   NvimTreeToggle
endfunction
]]

cmd [[
" manage quick fix
function! GetBufferList()
   redir =>buflist
   silent! ls!
   redir END
   return buflist
endfunction

function! ToggleList(bufname, pfx)
   let buflist = GetBufferList()
   for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufwinnr(bufnum) != -1
	 exec(a:pfx.'close')
	 return
      endif
   endfor
   if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
   endif
   let winnr = winnr()
   exec(a:pfx.'open')
   if winnr() != winnr
      wincmd p
   endif
endfunction

" auto set quickfix height
au FileType qf call AdjustWindowHeight(3, 8)
function! AdjustWindowHeight(minheight, maxheight)
   exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
]]


