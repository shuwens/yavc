" Coc
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Float color highlight
"hi CocErrorFloat guifg=#af0000
hi CocErrorFloat guifg=#ff5874
hi CocErrorSign guifg=#ff5874
hi CocWarningFloat guifg=#ddaa00
hi CocWarningSign guifg=#ddaa00
hi CocInfoSign guifg=#ffaf00
hi CocInfoFloat guifg=#ffaf00
hi CocHintFloat guifg=#2ed1cd

" Rust
call coc#config('rust', { 'clippy_preference': 'on' })

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <C-k>  <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j>  <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>.  <Plug>(coc-definition)
nmap <silent> <leader>y  <Plug>(coc-type-definition)
nmap <silent> <leader>i  <Plug>(coc-implementation)
nmap <silent> <leader>r  <Plug>(coc-references)
nmap <silent> <leader>o  <C-O>
nmap <silent> <leader>\  <C-O>
nmap <silent> <C-g> :close<cr>

" Use K to show documentation in preview window
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <silent> <leader>rn  <Plug>(coc-rename)

" Remap for format selected region
vmap <silent> <leader>f  <Plug>(coc-format-selected)
nmap <silent> <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <silent> <leader>a  <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <silent> <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <silent> <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" Do default action for next item.
"nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>

let g:coc_status_error_sign = "✗"
let g:coc_status_warning_sign = "⚠"

" Lightline config
"
" Add diagnostic info for https://github.com/itchyny/lightline.vim
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \		    [ 'cocstatus',  'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo',  ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'],
      \		     ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }


