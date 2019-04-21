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


