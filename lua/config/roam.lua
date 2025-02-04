-- https://github.com/samgriesemer/templates/blob/master/vim/.vimrc
local vim = vim
local g = vim.g
local opt = vim.opt

--█▓▒░  Wiki
g.wiki_root = '~/Dropbox/GS/notes'
g.wiki_filetypes = 'md'
g.wiki_write_on_nav = 1
g.wiki_journal = {
       'name' : '',
       'frequency' : 'daily',
       'date_format' : {
         'daily' : '%Y-%m-%d',
         'monthly' : '%Y-%m',
         'yearly' : '%Y',
       },
}
g.wiki_mappings_local = {
     '<plug>(wiki-link-toggle)' : '<Leader>wlt',
     '<plug>(wiki-fzf-toc)' : '<leader>wt',
     '<plug>(wiki-page-toc)' : '<Leader>wpt',
     '<plug>(wiki-journal-toweek)' : '<Leader>wjt',
     '<plug>(wiki-graph-find-backlinks)' : '<Leader>wlb',
 }
g.wiki_map_create_page = 'StringToFname'    --used through with `wn`
g.wiki_map_file2link = 'FnameToString'	    --file to link map, for renaming
g.wiki_resolver = 'WikiResolver'	    --transform link to filename
g.wiki_file_handler = 'WikiFileOpen'	    --handle wiki `file:` opening
g.wiki_post_page_open = 'WikiPostOpen'	    --callback after page open

vim.cmd([[
function! StringToFname(str)
    return substitute(a:str,' ','_','g')
endfunction

function! FnameToString(fname)
    return substitute(a:fname,'_',' ','g')
endfunction

function! WikiResolver(fname, origin)
  if empty(a:fname) | return a:origin | endif

  l:file = a:fname
  if fnamemodify(l:file, ':e') == 'md'
      l:file = fnamemodify(l:file, ':r')
  endif
  l:file = StringToFname(l:file)
  return simplify(wiki#get_root().'/'.l:file.'.md')
endfunction

function! WikiFileOpen(...) abort dict
  if self.path =~# 'pdf$'
    l:cmd = '!zathura '.fnameescape(self.path)
    if get(self, 'page')
        l:cmd .= ' -P '.string(self.page)
    endif
    silent execute l:cmd.' &'
    return 1
  endif
  return 0
endfunction

function! WikiPostOpen(fname)
    l:fnew = !filereadable(expand('%'))
    "l:fnew = filereadable(a:fname)

    " snippets for new files
    if l:fnew
      if a:fname =~# 'task-[a-z0-9]\{8\}.md'
        normal! iwn
        call UltiSnips#ExpandSnippet()
      endif
      if a:fname =~# '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}'
        normal! iwj
        call UltiSnips#ExpandSnippet()
      endif
    endif
endfunction
]])


--█▓▒░  Vim-Roam
g.roam_search_wrap_link = 'WrapLink'

vim.cmd([[
function! WrapLink(lines)
    "call feedkeys('A')
    l:link = join(a:lines)
    l:link = FnameToString(l:link)
    l:link = '[['.l:link.']]'

    if getcurpos()[2]+strlen(l:link) > &tw
        l:spacing = repeat(' ', &tw - getcurpos()[2])
        l:link = l:spacing . l:link
    endif

    " get link string for path (assumed relative to wiki root)
    return l:link
endfunction
]])

g.fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

--█▓▒░ Taskwiki config 
g.taskwiki_markup_syntax = 'markdown'
g.taskwiki_sort_order = 'status-,urgency-'
g.taskwiki_task_note_metadata = 1
g.taskwiki_disable_concealcursor = 1
"g.taskwiki_task_root = 'tasks'
"g.taskwiki_dont_preserve_folds = 1
"
