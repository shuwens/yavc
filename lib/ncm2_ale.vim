" NCM2 completion manager
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <C-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
"inoremap <expr> <CR> (pumvisible() ? "\<C-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" echo doc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

" Linter -- ALE
let g:ale_completion_enabled = 1
let g:ale_linters = {
      \ 'cpp' : ['rscmake', 'cppcheck', 'clangtidy', 'gcovcheck'],
      \ 'python': ['pyls',],
      \ 'LaTeX': ['proselint',],
      \ }
let g:ale_fixers = {
      \	'*': ['remove_trailing_lines', ],
      \ 'rust': ['rustfmt']
      \ }
" only lint when I want
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
" Figured out what these are for
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_set_ballons = 0
" Rust
let g:ale_rust_rls_config = {
      \ 'rust': {
      \ 'toolchain': 'nightly',
      \ 'all_targets': 1,
      \ 'build_on_save': 1,
      \ 'clippy_preference': 'off'
      \ }
      \ }
"
" ALE bindings
nmap <leader>l <Plug>(ale_lint)
nmap <leader>k <Plug>(ale_hover)
" Jump to next/previous error
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <leader>a <Plug>(ale_detail)
nmap <silent> <C-g> :close<cr>
" Emacs style
nmap <leader>. <Plug>(ale_go_to_definition)
nmap <leader>y <Plug>(ale_go_to_definition_in_vsplit)
nmap <leader>dd <Plug>(ale_go_to_type_definition)
nmap <leader>r <Plug>(ale_find_references)
" nmap <leader>\ <C-O>
nmap <leader>o <C-O>

" ALE format

" format error msg
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_loclist_msg_format='%s: %linter% %severity% (%code%)'

" complicated gui setup
"
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
"highlight ALEError guibg=#330000
"highlight ALEWarning guibg=#333300
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✗"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARN'
let g:ale_echo_msg_info_str = 'INFO'
let g:ale_error_format = '•%d'
let g:ale_warning_format = '•%d'
hi ale_error   cterm=None ctermfg=124 ctermbg=237
hi ale_warning cterm=None ctermfg=214 ctermbg=237
