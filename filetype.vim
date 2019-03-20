augroup filetypedetect
	" Git commit message
	autocmd Filetype gitcommit setlocal spell tw=72 colorcolumn=73

	" nftables
	autocmd BufRead,BufNewFile *.nft setfiletype nftables

	" Rust language server
	autocmd FileType rust let b:ale_linters = ['rustup', 'run', 'nightly', 'rls']
	" Follow Rust code style rules
	au Filetype rust source $HOME/.config/nvim/scripts/spacetab.vim
	au Filetype rust set colorcolumn=100

	" Shorter columns in text
	autocmd Filetype text setlocal  tw=72 colorcolumn=73
	autocmd Filetype markdown setlocal  tw=72 colorcolumn=73

	" proselint!!!
	autocmd Filetype tex let b:ale_linters = ['proselint', "lacheck", "chktex"]
	autocmd Filetype text let b:ale_linters = ['proselint']
	autocmd Filetype markdown let b:ale_linters = ['proselint']

	" LaTeX and TeX
	autocmd BufRead *.tex set filetype=tex
	"autocmd Filetype tex setlocal spell autoindent
	autocmd Filetype tex setlocal ts=2 sts=2 tw=80 colorcolumn=81 et
	"autocmd Filetype tex let g:tex_flavor = 'latex'
	autocmd Filetype tex setlocal syntax=context
	" LaTeX indent
	autocmd FileType tex let g:tex_indent_items=0
	autocmd FileType tex let g:tex_indent_and=0
	autocmd FileType tex let g:tex_indent_brace=0

	" fish
	autocmd FileType fish compiler fish
	autocmd FileType fish setlocal textwidth=79
	"autocmd FileType fish setlocal foldmethod=expr
	autocmd FileType fish setlocal nofoldenable
	autocmd FileType fish setlocal indentexpr=fish#Indent()
	autocmd FileType fish setlocal indentkeys+==end,=else,=case

	" lisp
	au BufNewFile,BufRead *.lsp,*.lisp,*.el,*.cl,*.jl,*.L,.emacs,.spacemacs setf lisp

	" other file types 
	au BufNewFile,BufRead .chunkwmrc,.skhdrc set filetype=sh

	" Auto-make less files on save
	autocmd BufWritePost *.less if filereadable("Makefile") | make | endif

	" Help filetype detection
	autocmd BufRead *.plot set filetype=gnuplot
	autocmd BufRead *.md set filetype=markdown
	autocmd BufRead *.lds set filetype=ld
	autocmd BufRead *.xlsx.axlsx set filetype=ruby
	autocmd BufRead *.trm set filetype=c
	autocmd BufRead *.org set filetype=org

	" Script plugins
	autocmd Filetype html,xml,xsl,php source $HOME/.config/nvim/scripts/closetag.vim
augroup END
