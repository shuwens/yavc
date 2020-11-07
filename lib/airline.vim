" Airline

" if you want to disable auto detect, comment out those two lines
" let g:airline#extensions#disable_rtp_load = 1
" let g:airline_extensions = ['branch', 'hunks', 'coc']

let g:airline_powerline_fonts = 1

" Sections
" --------
let g:airline_section_z = "%p%% \ue0a1 :%l/%L Col:%c"
"let g:airline_section_z = '%3p%% %3l/%L:%3v'
"let g:airline_section_z = '%3pp %l:%c'

" disable useless
let g:airline_detect_paste = 0      " I Don't need this. Never did.
let g:airline_detect_crypt = 0      " Useless.
let g:airline_detect_spell = 0      " Another useless thing.
let g:airline_exclude_preview = 1

" Extensions
" ---------
let g:airline#extensions#default#layout = [
         \ [ 'a', 'b', 'c' ],
         \ [ 'x', 'y', 'z', 'warning', 'error' ]
         \ ]
let g:airline#extensions#branch#format = 0    " Branch names as 'f/b/baz'.
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#ycm#enabled = 0
"let g:airline#extensions#whitespace#checks = [ 'trailing' ]
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'

" Themes
" ------
let g:airline_theme='base16'
" let g:airline_theme='base16_atelierdune'
" let g:airline_theme = 'forest_night'

"let g:airline_base16_improved_contrast = 1
let g:airline_symbols_ascii = 1

