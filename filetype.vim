augroup filetypedetect
	" Mail
	autocmd BufRead,BufNewFile /tmp/mutt*              setfiletype mail
	autocmd Filetype mail                              setlocal spell tw=72 colorcolumn=73
	autocmd Filetype mail                              setlocal fo+=w
	" Git commit message
	autocmd Filetype gitcommit                         setlocal spell tw=72 colorcolumn=73
	" nftables
	autocmd BufRead,BufNewFile *.nft setfiletype nftables
	" Go shortcuts
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <Leader>r <Plug>(go-rename)
	au FileType go nmap <leader>c <Plug>(go-coverage)
	" Rust language server
	"autocmd FileType rust let b:ale_linters = { 'rust': ['rls']}
	autocmd FileType rust nnoremap <leader>= :'<,'>RustFmtRange<cr>
	" Shorter columns in text
	"autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
	"autocmd Filetype text setlocal spell tw=72 colorcolumn=73
	"autocmd Filetype markdown setlocal spell tw=72 colorcolumn=73
	"autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
	"autocmd Filetype tex setlocal tabstop=4 shiftwidth=4 expandtab
	"autocmd FileType tex set tabstop=2|set shiftwidth=2|set noexpandtab
	"autocmd Filetype tex let g:tex_indent_items=0
	"autocmd Filetype tex let g:tex_indent_and=0
	"autocmd Filetype tex let g:tex_indent_brace=0
	autocmd Filetype text setlocal  tw=72 colorcolumn=73
	autocmd Filetype markdown setlocal  tw=72 colorcolumn=73
	" No autocomplete in text
	"autocmd BufRead,BufNewFile /tmp/mutt* let g:deoplete#enable_at_startup = 0
	" deoplete
	autocmd Filetype tex let g:deoplete#enable_at_startup = 0
	autocmd Filetype text let g:deoplete#enable_at_startup = 0
	autocmd Filetype markdown let g:deoplete#enable_at_startup = 0
	" proselint!!!
	autocmd Filetype tex let b:ale_linters = ['proselint']
	autocmd Filetype text let b:ale_linters = ['proselint']
	autocmd Filetype markdown let b:ale_linters = ['proselint']

autocmd FileType tex setlocal autoindent
" endelig!
 autocmd FileType tex let g:tex_indent_items=0
 autocmd FileType tex let g:tex_indent_and=0
 autocmd FileType tex let g:tex_indent_brace=0

augroup END
