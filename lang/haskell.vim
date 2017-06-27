" Highlight all the different types please
let g:hs_highlight_booleans = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1

" Automatically arrange imports in multilines when 
" import definition is really long
inoremap <silent>, <ESC>:call <SID>hsArrangeImports(',')<CR>a
inoremap <silent>) <ESC>:call <SID>hsArrangeImports(')')<CR>a

""""""""""""""""""""
"" hsArrengeImports + helpers

function! s:nextLine()
  if line('.') == line('$')
    return line('$')
  else
    return line('.') + 1
  endif
endfunction

function! s:isImportLine(importLine)
  return len(a:importLine) > 79 &&  
        \ match(a:importLine, 'import') == 0
endfunction

function! s:appendImport(importToken, sep)
  let l:lineNr = s:nextLine()
  call append(l:lineNr, ["  " . a:sep . a:importToken])
  call cursor(l:lineNr + 1, col('1'))
endfunction

function! s:appendClosingChar(chr)
  let l:lineNr = s:nextLine()
  if a:chr == ","
    call append(l:lineNr, "  , ")
    call cursor(l:lineNr + 1, col('$'))
  else
    call append(l:lineNr, "  )")
    call cursor(l:lineNr + 1, col('$') - 1)
  endif
endfunction

function! s:appendImports(importLine, chr)
  let l:importLines = split(a:importLine, ',')
  call s:appendImport(l:importLines[0], '  ')
  for l:line in l:importLines[1:]
    let l:strippedLine = substitute(l:line, '^\s\+\(.\+\)\s\+$', '\1', '')
    call s:appendImport(l:strippedLine, ',')
  endfor
  call s:appendClosingChar(a:chr)
endfunction

function! s:hsArrangeImports(chr)
  let l:current = getline('.')
  let l:pre = l:current[0:col('.') - 1]
  let l:post = l:current[col('.'):]
  if s:isImportLine(l:current)
    let l:start_pos = match(l:current, '(') + 1
    call setline(line('.'), l:current[0 : (l:start_pos - 1)])
    call s:appendImports(l:current[(l:start_pos):], a:chr)
  else
    call setline(line('.'), l:pre . a:chr . l:post)
    call search(a:chr, 'ce', line('.'))
  endif
endfunction

""""""""""""""""""""

" Haskell syntastic 
" http://www.stephendiehl.com/posts/vim_2016.html
" http://www.stephendiehl.com/posts/vim_haskell.html
map <silent> <Leader>e :Errors<CR>
" To always show the errors list when editing
"let g:syntastic_auto_loc_list=1

" syntastic

map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ghc-mod
autocmd FileType haskell map <silent> tw :GhcModTypeInsert<CR>
autocmd FileType haskell map <silent> ts :GhcModSplitFunCase<CR>
autocmd FileType haskell map <silent> tq :GhcModType<CR>
autocmd FileType haskell map <silent> te :GhcModTypeClear<CR>

" neco-ghc
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


" Haskell wiki

" Tab specific option
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple

let s:width = 80

function! HaskellModuleSection(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")

    return  repeat('-', s:width) . "\n"
    \       . "--  " . name . "\n"
    \       . "\n"

endfunction

nmap <silent> --s "=HaskellModuleSection()<CR>gp

function! HaskellModuleHeader(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
    let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
    let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
    
    return  repeat('-', s:width) . "\n" 
    \       . "-- | \n" 
    \       . "-- Module      : " . name . "\n"
    \       . "-- Note        : " . note . "\n"
    \       . "-- \n"
    \       . "-- " . description . "\n"
    \       . "-- \n"
    \       . repeat('-', s:width) . "\n"
    \       . "\n"

endfunction

nmap <silent> --h "=HaskellModuleHeader()<CR>:0put =<CR>

 au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
 au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
