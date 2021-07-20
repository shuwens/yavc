" Lightline config

" Plugin settings
let g:secure_modelines_allowed_items = [
			\ "textwidth",   "tw",
			\ "softtabstop", "sts",
			\ "tabstop",     "ts",
			\ "shiftwidth",  "sw",
			\ "expandtab",   "et",   "noexpandtab", "noet",
			\ "filetype",    "ft",
			\ "foldmethod",  "fdm",
			\ "readonly",    "ro",   "noreadonly", "noro",
			\ "rightleft",   "rl",   "norightleft", "norl",
			\ "colorcolumn"
			\ ]

" Lightline
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
				\   'left': [ [ 'mode', 'paste' ],
				\		    [  'gitbranch', ],
				\             [ 'readonly', 'filename', 'modified' ] ],
				\   'right': [ [ 'lineinfo' ],
				\              [ 'percent' ],
				\              [ 'fileformat', 'fileencoding', 'filetype'] ]
				\ },
				\ 'component_function': {
					\   'gitbranch': 'fugitive#head',
					\   'filetype': 'LightlineFiletype',
					\   'fileformat': 'LightlineFileformat',
					\   'filename': 'LightlineFilename'
					\ },
					\   'separator': { 'left': '▒', 'right': '▒' },
					\   'subseparator': { 'left': '▒', 'right': '░' }
					\ }
function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineGitBranch()
	return "\uE725 " . (exists('*fugitive#head') ? fugitive#head() : '')
endfunction


