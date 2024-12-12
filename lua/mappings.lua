local vim = vim
local api = vim.api
local g = vim.g
local cmd = vim.cmd
local opts = { noremap = true, silent = true }

vim.diagnostic.config {
	underline = true,
	virtual_text = { severity = nil, source = "if_many", format = nil },
	signs = true,

	-- options for floating windows:
	float = { show_header = true },

	-- general purpose
	severity_sort = true,
	update_in_insert = false
}

-- See `:help vim.lsp.*` for documentation on any of the below functions
api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
api.nvim_set_keymap('n', 'sd', '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>', opts)
api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next({wrap = true, float = false})<CR>', opts)
api.nvim_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next({wrap = true, float = false})<CR>', opts)
api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev({wrap = true, float = false})<CR>', opts)

vim.cmd [[
" <leader>s for Rg search
" noremap <leader>s :Rg<CR>
" let g:fzf_layout = { 'down': '~30%' }
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)
"
" function! s:list_cmd()
"   let base = fnamemodify(expand('%'), ':h:.:S')
"   return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
" endfunction
"
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
"   \                               'options': '--tiebreak=index'}, <bang>0)
" ]]

-- files and buffers
-- api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', g.mapleader .. ';', ':Buffers<CR>', { noremap = true, silent = false })

-- Neat X clipboard integration linux
if vim.fn.has("mac") == 1 then
	-- Paste clipboard content to current line
	api.nvim_set_keymap('v', g.mapleader .. 'y', ':w !pbcopy<CR><CR>', opts)
	api.nvim_set_keymap('n', g.mapleader .. 'p', ':r !pbpaste<CR>', opts)
elseif vim.fn.has("unix") == 1 then
	api.nvim_set_keymap('v', g.mapleader .. 'y', ':w !xsel -ib<CR><CR>', opts)
	api.nvim_set_keymap('n', g.mapleader .. 'p', ':read !xsel --clipboard --output<CR>', opts)
else
	print("Unsupported system!")
end
api.nvim_set_keymap('v', '<C-c>', '"*y', opts)


-- format paragraph
api.nvim_set_keymap('n', 'Q', 'gq{', { noremap = true, silent = false })

-- Open new file adjacent to current file
api.nvim_set_keymap('n', g.mapleader .. 'e', ':e <C-R>=expand("%:p:h") . "/" <CR>', { noremap = true, silent = false })

-- Keymap for replacing up to next _ or -
api.nvim_set_keymap('n', g.mapleader .. 'm', 'ct_', { noremap = true, silent = false })
api.nvim_set_keymap('n', g.mapleader .. 'n', 'ct-', { noremap = true, silent = false })

-- detele things shortcut
api.nvim_set_keymap('n', '<C-i>', 'C', opts)
-- api.nvim_set_keymap('n', g.mapleader..'i', 'C', opts)

api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', 'q', '<nop>', opts)

-- Move by line
api.nvim_set_keymap('n', 'j', 'gj', opts)
api.nvim_set_keymap('n', 'k', 'gk', opts)

-- I can type :help on my own, thanks.
api.nvim_set_keymap('n', '<F1>', '<Esc>', { noremap = true, silent = false })
api.nvim_set_keymap('n', '<F1>', '<Esc>', { noremap = true, silent = false })

-- Visual mode pressing * or # searches for the current selection
api.nvim_set_keymap('v', '*', ':call VisualSelection("f")<CR>', opts)
api.nvim_set_keymap('v', '#', ':call VisualSelection("b")<CR>', opts)

-- F3 to insert a logical clock
api.nvim_set_keymap('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>', { noremap = true, silent = false })
api.nvim_set_keymap('i', '<F3>', '<c-r>=strftime("%c")<CR>', { noremap = true, silent = false })

-- Search results centered please
api.nvim_set_keymap('n', 'n', 'nzz', opts)
api.nvim_set_keymap('n', 'N', 'Nzz', opts)
api.nvim_set_keymap('n', '*', '*zz', opts)
api.nvim_set_keymap('n', '#', '#zz', opts)
api.nvim_set_keymap('n', 'g*', 'g*zz', opts)

cmd [[
" Remap VIM 0 to first non-blank character
map 0 ^
" Jump to start and end of line using the home row key
map H ^
map L $

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ; as :
inoremap jh <Esc>
inoremap jj <Esc>
inoremap jk <Esc>
nnoremap Y y$
nnoremap gUiw mzgUiw`z
nnoremap guiw mzguiw`z

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

autocmd BufRead,BufNewFile $HOME/dev/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/projects/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/achtung/survey/src/** let b:dispatch = 'make'
autocmd BufRead,BufNewFile $HOME/dev/achtung/audit/src/** let b:dispatch = 'make clean; make'
autocmd BufRead,BufNewFile $HOME/writings/blogs/** let b:dispatch = 'zola build'

" find merge conflict markers
nmap <silent> <leader>mc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

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

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
   exe "normal mz"
   %s/\s\+$//ge
   exe "normal `z"
endfunc

]]

-- " A second kind of re-wrap
-- " Reformat lines (getting the spacing correct)
-- "
-- " https://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
-- fun! TeX_fmt()
--    if (getline(".") != "")
--       let save_cursor = getpos(".")
--       let op_wrapscan = &wrapscan
--       set nowrapscan
--       let par_begin = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
--       let par_end   = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
--       try
-- 	 exe '?'.par_begin.'?+'
--       catch /E384/
-- 	 1
--       endtry
--       norm V
--       try
-- 	 exe '/'.par_end.'/-'
--       catch /E385/
-- 	 $
--       endtry
--       norm gq
--       let &wrapscan = op_wrapscan
--       call setpos('.', save_cursor)
--    endif
-- endfun
-- autocmd Filetype markdown nmap Q :call TeX_fmt()<CR>zz
-- autocmd Filetype tex nmap Q :call TeX_fmt()<CR>zz
-- autocmd Filetype org nmap Q :call TeX_fmt()<CR>zz
-- autocmd Filetype jemdoc nmap Q :call TeX_fmt()<CR>zz
-- autocmd Filetype text nmap Q :call TeX_fmt()<CR>zz



-- Deprecated things

-- api.nvim_set_keymap('n', g.mapleader..'y', [["*y]], opts)
-- api.nvim_set_keymap('v', g.mapleader..'y', [["*y]], opts)
-- api.nvim_set_keymap('n', g.mapleader..'x', [["*x]], opts)
-- api.nvim_set_keymap('v', g.mapleader..'x', [["*x]], opts)
-- api.nvim_set_keymap('n', g.mapleader..'p', [["*p]], opts)
-- api.nvim_set_keymap('v', g.mapleader..'p', [["*p]], opts)
-- api.nvim_set_keymap('n', g.mapleader..'a', 'ggVG', opts)
-- api.nvim_set_keymap('n', g.mapleader..'bd', ':bd<cr>', opts)
-- api.nvim_set_keymap('t', g.mapleader..'<Esc>', [[<C-\><C-n>]], opts)
-- api.nvim_set_keymap('n', 'Q', '<Nop>', opts)
-- api.nvim_set_keymap('n', g.mapleader..'gg', ':enew', opts)

-- Undo tree
-- api.nvim_set_keymap('n', g.mapleader..'u', ':UndotreeToggle<CR>', { noremap = true, silent = false })

-- <leader><leader> toggles between buffers
-- api.nvim_set_keymap('n', g.mapleader..g.mapleader, '<c-^>', { noremap = true, silent = false })

-- <leader>q shows stats
-- api.nvim_set_keymap('n', g.mapleader..'Q', 'g<c-g>', { noremap = true, silent = false })

-- Quick-save
-- api.nvim_set_keymap('n', g.mapleader..'w', ':StripWhitespace<CR>:w<CR>', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', g.mapleader..'wq', ':wq<CR>', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', g.mapleader..'q', ':q!<CR>', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', g.mapleader..'qq', ':q!<Esc>:q!<CR>', { noremap = true, silent = false })

-- vim-dispatch
-- api.nvim_set_keymap('n', g.mapleader..'d', ':Dispatch<CR>', { noremap = true, silent = false })

-- nnoremap <leader>c :Commits<CR>

-- " resize current split by +/- 5
-- nnoremap <silent> + :exe "vertical resize +5"<CR>
-- nnoremap <silent> - :exe "vertical resize -5"<CR>
-- nnoremap <silent> <leader>] :exe "resize +5"<CR>
-- nnoremap <silent> <leader>[ :exe "resize -5"<CR>

-- Fugitive Conflict Resolution
-- nnoremap <leader>gd :Gvdiff<CR>
-- nnoremap gdh :diffget //2<CR>
-- nnoremap gdl :diffget //3<CR>

-- " Replaced gundo with UndoTree, pure vimscript instead of dependencies
-- nnoremap <leader>u :UndotreeToggle<CR>

-- api.nvim_set_keymap('n', '<C-a>', '<C-o>0', opts)
-- api.nvim_set_keymap('n', '<C-z>', '<C-o>$', opts)

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
