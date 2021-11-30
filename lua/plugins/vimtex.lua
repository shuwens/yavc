-- https://www.reddit.com/r/neovim/comments/idthcb/vimtex_vs_texlab/
-- https://castel.dev/post/lecture-notes-1/

-- https://github.com/ihasdapie/dotfiles/blob/main/nvim/.config/nvim/lua/vimtex_bindings.lua
vim.cmd(([[
autocmd FileType tex lua whichkey_latex()
]]))

_G.whichkey_latex = function ()
  local wk = require('which-key')
  wk.register({
    dse = "vimtex env-delete",
    dsc = "vimtex cmd-delete",
    ['ds$'] = "vimtex env-delete-math",
    dsd = "vimtex delim-delete",
    cse = "vimtex env-change",
    csc = "vimtex cmd-change",
    ['cs$'] = "vimtex env-change-math",
    csd = "vimtex delim-change-math",
    tsc = "vimtex cmd-toggle-star",
    tse = "vimtex env-toggle-star",
    K = "vimtex doc-package",

    ['<localleader>'] = {
      l = {
	name = '+vimtex',
	i = "vimtex info",
	I = "vimtex info-full",
	t = "vimtex toc-open",
	T = "vimtex toc-toggle",
	q = "vimtex log",
	v = "vimtex view",
	r = "vimtex reverse-search",
	l = "vimtex compile",
	k = "vimtex stop",
	K = "vimtex stop-all",
	e = "vimtex errors",
	o = "vimtex compile-output",
	g = "vimtex status",
	G = "vimtex status-all",
	c = "vimtex clean",
	C = "vimtex clean-full",
	m = "vimtex imaps-list",
	x = "vimtex reload",
	X = "vimtex reload-state",
	s = "vimtex toggle-main",
	a = "vimtex context-menu",
	L = "vimtex compile-selected"
      }
    }
  })
end
