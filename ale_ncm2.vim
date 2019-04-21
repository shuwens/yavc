" ALE
Plug 'maximbaz/lightline-ale'
Plug 'w0rp/ale'

" NCM2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
" LSP
" FIXME: this is temporary as ncm2 will be able to use ALE LSP client later
" https://github.com/ncm2/ncm2/issues/121
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" NCM2 completion manager {{{
" NOTE: At some point I might want to switch to coc, if I want support for other
" programming language outside LSP.
"
"autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
" }}}
" LSP completion backend{{{
" FIXME: I believe ALE completion should be able to do this, however I can't
" get that to work for now.
let g:LanguageClient_serverCommands = {
      \ 'rust': ['ra_lsp_server'],
      \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#type = 'virtual'
" }}}
" Status Line {{{
" Lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \		  [ 'gitbranch', 'readonly', 'filename', 'modified' ]
      \		],
      \  'right': [
      \             ['lineinfo'],
      \		    ['percent'],
      \		    ['fileformat', 'fileencoding', 'filetype', 'teststatus'],
      \		    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \           ]
      \ },
      	\   'component': {
	\     'lineinfo': '%3l:%-2v',
	\   },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'teststatus': 'TestStatus',
      \ },
      \ }
" better light line?
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline#ale#indicator_checking = "•"
let g:lightline#ale#indicator_warnings = "•"
let g:lightline#ale#indicator_errors = "•"
"let g:lightline#ale#indicator_ok = "\uf00c"

" Cargo test in lightline {{{2
let g:TestStatus=-1
function! TestStatus()
  if &filetype != "rust"
    return ""
  elseif g:TestStatus == -1
    return "[Test: N/A]"
  elseif g:TestStatus == 0
    return "[Test: OK.]"
  else
    return "[Test: ERR]"
  endif
endfunction
function! s:BgCmdCB(job_id, data, event)
  call writefile([join(a:data)], g:bgCmdOutput, 'a')
endfunction
function! s:BgCmdExit(job_id, data, status)
  let l:bufno = bufwinnr("__Bg_Res__")
  echo 'Running' g:bgCmd 'in background... Done.'
  let g:TestStatus=a:data
  " Change status line to show errors
  if a:data > 0
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
    if l:bufno == -1
      below 8split __Bg_Res__
      let l:bufno = bufwinnr("__Bg_Res__")
    else
      execute bufno . "wincmd w"
    endif
    normal! ggdG
    setlocal buftype=nofile
    call append(0,readfile(g:bgCmdOutput))
    normal! gg
    execute "-1 wincmd w"
  else
    " Restore status line
    hi statusline term=bold,reverse cterm=bold ctermfg=233 ctermbg=66 gui=bold guifg=#1c1c1c guibg=#5f8787
    " Close tests result window
    if l:bufno != -1
      execute bufno . "wincmd w"
      close
    endif
  endif
  unlet g:bgCmdOutput
endfunction

function! RunBgCmd(command)
  let g:bgCmd = a:command
  if exists('g:bgCmdOutput')
    echo 'Task' g:bgCmd 'running in background'
  else
    echo 'Running' g:bgCmd 'in background'
    let g:bgCmdOutput = tempname()
    call jobstart(a:command,{
	  \'on_stderr': function('s:BgCmdCB'),
	  \'on_stdout': function('s:BgCmdCB'),
	  \'on_exit': function('s:BgCmdExit')})
  endif
endfunction

command! -nargs=+ -complete=shellcmd RunBg call RunBgCmd(<q-args>)
autocmd FileType rust nmap <leader>t :RunBg cargo test<CR>
autocmd FileType rust nmap <leader>tc :RunBg cargo test -- --nocapture<CR>
" }}}

" Linter -- ALE {{{
" lint should be handled by LSP, but seems like that Rust is bit broken
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
let g:ale_completion_enabled = 0
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

" ALE format {{{2

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
let g:ale_sign_error = "✖"
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
" }}}
" }}}
