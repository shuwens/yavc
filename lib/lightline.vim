let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
	\   'right': [ [ 'lineinfo',  ],
	\              [ 'percent' ],
	\              [ 'fileformat', 'fileencoding', 'filetype'] ]
	\ },
  \ 'component_expand': {
  \   'coc_error'        : 'LightlineCocErrors',
  \   'coc_warning'      : 'LightlineCocWarnings',
  \   'coc_info'         : 'LightlineCocInfos',
  \   'coc_hint'         : 'LightlineCocHints',
  \   'coc_fix'          : 'LightlineCocFixes',
  \ },
  \ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = "•"
  endtry
  return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'hint')
endfunction
\ }


        function! LightlineFileName() abort
            let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
            if filename =~ 'NERD_tree'
                return ''
            endif
            let modified = &modified ? ' +' : ''
            return fnamemodify(filename, ":~:.") . modified
        endfunction

        function! LightlineFileEncoding()
            " only show the file encoding if it's not 'utf-8'
            return &fileencoding == 'utf-8' ? '' : &fileencoding
        endfunction

        function! LightlineFileFormat()
            " only show the file format if it's not 'unix'
            let format = &fileformat == 'unix' ? '' : &fileformat
            return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
        endfunction

        function! LightlineFileType()
            return WebDevIconsGetFileTypeSymbol()
        endfunction

        function! LightlineLinter() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
        endfunction

        function! LightlineLinterWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
        endfunction

        function! LightlineLinterErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
        endfunction

        function! LightlineLinterOk() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? 'OK' : ''
        endfunction

        function! LightlineGitBranch()
            return "\uE725" . (exists('*fugitive#head') ? fugitive#head() : '')
        endfunction

        function! LightlineUpdate()
            if g:goyo_entered == 0
                " do not update lightline if in Goyo mode
                call lightline#update()
            endif
        endfunction

autocmd User CocDiagnosticChange call lightline#update()

let g:coc_status_error_sign = "✗"
let g:coc_status_warning_sign = "⚠"
