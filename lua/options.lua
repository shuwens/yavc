local vim = vim
local opt = vim.opt

opt.nu = true
opt.rnu = true

opt.showmode = false      -- We show the mode with airline or lightline
opt.showcmd = true        -- Show (partial) command in status line.
opt.cmdheight = 2         -- Height of the command bar
opt.showmatch = true      -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true         -- But show the actual number for the line we're on
opt.hidden = true         -- Hides buffers instead of closing them
opt.equalalways = false   -- I don't like my windows changing all the time
-- opt.updatetime = 1000   -- Make updates happen faster
opt.updatetime = 250      -- update interval for gitsigns
opt.hlsearch = true       -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10        -- Make it so there are always ten lines below my cursor
-- opt.smoothscroll = true

-- Proper search
opt.incsearch = true  -- Makes search act like search in modern browsers
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ... unless there is a capital letter in the query
opt.gdefault = true   -- search/replace "globally" (on a line) by default

-- Sane splits
opt.splitright = true -- Split vertical windows right to the current windows
opt.splitbelow = true -- Split horizontal windows below to the current windows

-- GUI settings
-- opt.guioptions = opt.guioptions - "T" -- Remove toolbar
-- opt.vb = "t_vb=" -- No more beeps
opt.backspace = "2" --Backspace over newlines
opt.tw = 79
opt.cursorline = true
opt.cursorcolumn = true
opt.ttyfast = true
-- https://github.com/vim/vim/issues/1735#issuecomment-383353563
opt.lazyredraw = true                -- don't update the display while executing macros<Paste>
opt.synmaxcol = 500
opt.laststatus = 2                   --  always have a statusline
opt.diffopt = opt.diffopt + "iwhite" -- No whitespace in vimdiff
-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
opt.diffopt = opt.diffopt + "internal,algorithm:patience"
opt.diffopt = opt.diffopt + "indent-heuristic"
opt.colorcolumn = "80"              -- and give me a colored column
opt.shortmess = opt.shortmess + "c" -- don't give |ins-completion-menu| messages.

-- Editor settings
-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true
-- opt.wrap = false       -- do not wrap long lines by default

-- set the width of the tab to 4 wide
-- This gets overridden by vim-sleuth, so that's nice
-- Some other tips from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "a"

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

vim.opt.undofile = true
vim.opt.signcolumn = "yes"

opt.ruler = true      -- Where am I?
opt.ignorecase = true -- Search case insensitive...

-- I only use VIM from the terminals
-- opt.termguicolors = true -- screen does not (yet) support truecolor

opt.cul = true
opt.mouse = "a"        -- Enable mouse usage (all modes) in terminals
opt.signcolumn = "yes" -- Always draw sign column. Prevent buffer moving when adding/deleting sign.

-- Time out on key codes but not mappings.
-- Basically this makes terminal Vim work sanely.
opt.timeoutlen = 350 -- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- opt.notimeout = true
-- opt.ttimeout = true
-- opt.ttimeoutlen = 10

opt.background = "dark"
opt.whichwrap:append("<>hl")
opt.pumheight = 20

-- Permanent undo
opt.undofile = true
opt.undodir = vim.fn.getenv("HOME") .. "/.vimdid"

vim.cmd "set wildcharm=<Tab>"

-- filetype plugin indent on                   " required
opt.encoding = "utf-8" -- default encoding to UTF-8
opt.joinspaces = false -- Prevents inserting two spaces after punctuation on a join (J)

-- set the width of the tab to 4 wide
-- This gets overridden by vim-sleuth, so that's nice
-- Some other tips from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.tags = ".git/tags"

-- Decent wildmenu
opt.wildmenu = true
--opt.wildmode=list:longest
opt.wildmode = "list:full"
--opt.wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
opt.wildignore = "+= .hg,.git,.svn"                   --Version control
opt.wildignore = "+=*.aux,*.out,*.toc"                --LaTeX intermediate files
opt.wildignore = "+=*.jpg,*.bmp,*.gif,*.png,*.jpeg"   --binary images
opt.wildignore = "+=*.o,*.obj,*.exe,*.dll,*.manifest" --compiled object files
opt.wildignore = "+=*.spl"                            --compiled spelling word lists
opt.wildignore = "+=*.sw?"                            --Vim swap files
opt.wildignore = "+=*.DS_Store"                       --OSX bullshit
opt.wildignore = "+=*.luac"                           --Lua byte code
opt.wildignore = "+=migrations"                       --Django migrations
opt.wildignore = "+=go/pkg"                           --Go static files
opt.wildignore = "+=go/bin"                           --Go bin files
opt.wildignore = "+=go/bin-vagrant"                   --Go bin-vagrant files
opt.wildignore = "+=*.pyc"                            --Python byte code
opt.wildignore = "+=*.orig"                           --Merge resolution files

-- Wrapping options
opt.formatoptions = "tc"                    -- wrap text and comments using textwidth
opt.formatoptions = opt.formatoptions + "r" -- continue comments when pressing ENTER in I mode
opt.formatoptions = opt.formatoptions + "q" -- enable formatting of comments with gq
opt.formatoptions = opt.formatoptions + "n" -- detect lists for formatting
opt.formatoptions = opt.formatoptions + "b" -- auto-wrap in insert mode, and do not wrap old long lines

-- Completion
-- Better completion
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
-- opt.completeopt = "menuone,noinsert,noselect"
opt.completeopt = { "menu", "menuone", "noselect" }
vim.cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"

-- Show those damn hidden characters
-- Verbose: opt.listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
opt.listchars = "nbsp:¬,extends:»,precedes:«,trail:•"

-- Make pyenv and neovim work nice together
opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
opt.inccommand = "nosplit"

-- spell setting
vim.cmd([[
set spelllang=en_us
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor
set spellsuggest=best,9
hi clear SpellBad
" hi SpellBad ctermfg=000 guifg=#000
hi SpellBad cterm=underline gui=undercurl

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
]])

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

opt.termguicolors = true
vim.cmd [[colorscheme kanagawa]]
-- vim.cmd "colorscheme gruvbox-material"
-- vim.cmd "colorscheme codedark"
