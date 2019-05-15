" Linter -- ALE
" lint should be handled by LSP, but seems like that Rust is bit broken
let g:ale_linters = {
      \ 'rust': ['rls'],
      \ 'cpp' : ['rscmake', 'cppcheck', 'clangtidy', 'gcovcheck'],
      \ 'python': ['pyls',],
      \ 'LaTeX': ['proselint',],
      \	'sh': ['shellcheck']
      \ }
let g:ale_fixers = {
      \	'*': ['remove_trailing_lines', ],
      \ 'rust': ['rustfmt'],
      \ 'c': ['clang-format'],
      \ 'cpp': ['clang-format']
      \ }
" only lint when I want
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 0
let g:ale_virtualtext_cursor = 1
" Figured out what these are for
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_set_ballons = 0
" Rust
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_rust_rls_config = {
      \ 'rust': {
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
hi ale_error   cterm=None ctermfg=124 ctermbg=237
hi ale_warning cterm=None ctermfg=214 ctermbg=237

let g:ale_sign_error = "✗"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARN'
let g:ale_echo_msg_info_str = 'INFO'
let g:ale_error_format = '•%d'
let g:ale_warning_format = '•%d'
