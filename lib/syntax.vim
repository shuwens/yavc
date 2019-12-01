
" LaTeX
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []
"let g:tex_conceal = ""
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'
autocmd BufNewFile,BufRead *.tex set syntax=context

" chromatica
if !empty(glob("/usr/local/opt/llvm/lib"))
  let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
  let g:chromatica#enable_at_startup=1
endif

" thesaurus_query.vim
let g:tq_map_keys=0
nnoremap <leader>t :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <leader>t y:ThesaurusQueryReplace <C-r>"<CR>

" VIM spell
set spelllang=en_us
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl

" Javascript
let javaScript_fold=0

" Golang
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>r <Plug>(go-rename)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/others/r/bin")
let g:go_version_warning = 0

"█▓▒░ Rust
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

" markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

