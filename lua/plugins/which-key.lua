-- https://github.com/mrkatebzadeh/Siarch/blob/master/nvim/.config/nvim/lua/whichkey_config.lua
local wk = require("which-key")
local g = vim.g
local goto_opts = { wrap = true, float = true }

wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually
})

wk.register({
  [" "] = {'<c-^>', "Jump to last"},
  -- ["<CR>"] = "Open Terminal (Buffer)",
  -- ["`"] = "Open Terminal (Horizontal)",
  -- a = "Select all",
  -- <leader><leader> toggles between buffers
  b = {
    name = '+Buffer',
    b = {':Buffers<CR>'                , 'fzf-buffer'},
    g = {':Gitsigns toggle_current_line_blame<CR>', "Show blame for line"},
    -- d = {':BufferClose<CR>'               , 'delete-buffer'},
    n = {':bnext<CR>'                  , 'next-buffer'},
    p = {':bprevious<CR>'              , 'previous-buffer'},
    l = {':BufferLinePick<CR>'                , 'buffer line pick'},
    B = {':BufferPick<CR>'                , 'fzf-buffer pick'},
  },
  c = {
    name = "+QuickFix List",
    n = {"<cmd>:cn<CR>", "Next item in QuickFix list"},
    N = {"<cmd>:cp<CR>", "Prev item in QuickFix list"},
    q = {"<cmd>:cclose<CR>", "Close QuickFix list"},
    g = {"<cmd>:cfirst<CR>", "First item in QuickFix list"},
    G = {"<cmd>:clast<CR>", "Last item in QuickFix list"},
    o = {"<cmd>:copen<CR>", "Open QuickFix list"},
  },
  d = {':Dispatch<CR>', "Dispatch"},
  f = {
    name = "+Fuzzy Search",
    f = {"<cmd>lua require('fzf-lua').files()<CR>", "file"},
    b = {"<cmd>lua require('fzf-lua').buffers()<CR>", "buffer"},
    q = {"<cmd>lua require('fzf-lua').quickfix()<CR>", "quickfix"},
    l = {"<cmd>lua require('fzf-lua').loclist()<CR>", "loc list"},
    p = {"<cmd>lua require('fzf-lua').grep_project()<CR>", "Rg project"},
    w = {"<cmd>lua require('fzf-lua').grep_cword()<CR>", "Current word"},
    g = {"<cmd>lua require('fzf-lua').live_grep_native()<CR>", "Live grep"},
    c = {"<cmd>lua require('fzf-lua').git_commits()<CR>", "Git commits"},
  },
  g = {
    name = "+Git/Grammar",
    g = {':GrammarousCheck --lang=en-US --preview<CR>', "Grammar check"},
    m = {"<ESC>/\v^[<=>]{7}( .*\\|$)<CR>", "Merge Conflict"},
    l = {':LazyGit<CR>', "Lazy Git"},
  },
  h = {':TroubleToggle<CR>' , "Errors Dashboard"},
  l = {
    name = '+lsp' ,
    f = {':lua vim.lsp.buf.formatting()<CR>'                      , 'format'},
    I = {':LspInfo<CR>'                            , 'lsp info'},
    v = {':LspVirtualTextToggle<CR>'               , 'lsp toggle virtual text'},
    T = {':lua vim.lsp.buf.type_definition()<CR>'                  , 'type defintion'},
    x = {':cclose<CR>'                             , 'close quickfix'},
    g = {
      name = '+goto' ,
      d = {':LspDefinition<CR>'      , 'Goto Definition'},
      y = {':LspTypeDefinition<CR>' , 'Goto Type Definition'},
      i = {':LspImplementation<CR>'  , 'Goto Implementation'},
      r = {':LspReferences<CR>'      , 'Goto References'},
    }
  },
  Q = {'g<c-g>', "Show stats"},
  -- n = "Explorer",
  u = {':UndotreeToggle<CR>', "Undo Tree"},
  v = {
    name = "+Lsp",
    d = {'<cmd>lua vim.lsp.buf.definition()<CR>', "Goto Definition"},
    D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', "Goto Declaration"},
    i = {'<cmd>lua vim.lsp.buf.implementation()<CR>', "Goto Implementation"},
    h = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover Documentation"},
    s = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help"},
    l = {'<cmd>lua LspLocationList()<CR>', "Lsp Location"},
    n = {'<cmd>lua vim.diagnostic.goto_next(goto_opts)<CR>', "Goto Next Diagnostics"},
    r = {
      name = "Reference / Rename",
      r = {'<cmd>lua vim.lsp.buf.references()<CR>', "Reference"},
      n = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
    },
    c = {
      name = "+Code Action",
      a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Actions"},
      c = {'<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>', "Line Diagnostics"},
      -- d = {'<cmd>lua vim.diagnostic.show_cursor_diagnostics()<CR>', "Line Diagnostics"},
    },
    g = {
      name = '+goto' ,
      t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Goto type def'},
      d = {':LspDefinition<CR>'      , 'Goto Definition'},
      y = {':LspTypeDefinition<CR>' , 'Goto Type Definition'},
      i = {':LspImplementation<CR>'  , 'Goto Implementation'},
      r = {':LspReferences<CR>'      , 'Goto References'},
    }
  },
  w = {':StripWhitespace<CR>:w<CR>', "Write and rm space"},
  W = {
    name = '+windows' ,
    w = {'<C-W>w'     , 'other-window'}          ,
    d = {'<C-W>c'     , 'delete-window'}         ,
    ['-'] = {'<C-W>s'     , 'split-window-below'}    ,
    ['|'] = {'<C-W>v'     , 'split-window-right'}    ,
    ['2'] = {'<C-W>v'     , 'layout-double-columns'} ,
    h = {'<C-W>h'     , 'window-left'}           ,
    j = {'<C-W>j'     , 'window-below'}          ,
    l = {'<C-W>l'     , 'window-right'}          ,
    k = {'<C-W>k'     , 'window-up'}             ,
    H = {'<C-W>5<'    , 'expand-window-left'}    ,
    J = {':resize +5<CR>'  , 'expand-window-below'}   ,
    L = {'<C-W>5>'    , 'expand-window-right'}   ,
    K = {':resize -5<CR>'  , 'expand-window-up'}      ,
    ['='] = {'<C-W>='     , 'balance-window'}        ,
    s = {'<C-W>s'     , 'split-window-below'}    ,
    v = {'<C-W>v'     , 'split-window-below'}    ,
    ['?'] = {'Windows'    , 'fzf-window'}            ,
  },
}, {
  prefix = g.mapleader,
})

wk.register({
  ["1"] = "Go to Buffer 1",
  ["2"] = "Go to Buffer 2",
  ["3"] = "Go to Buffer 3",
  ["4"] = "Go to Buffer 4",
  ["5"] = "Go to Buffer 5",
  ["6"] = "Go to Buffer 6",
  ["7"] = "Go to Buffer 7",
  ["8"] = "Go to Buffer 8",
  ["9"] = "Go to Buffer 9",
}, {
  prefix = g.altleader,
})

wk.register({
  ["``"]= {':nohlsearch<CR>:call minimap#vim#ClearColorSearch()<CR>', "Clear highlighted searches"},
  -- surround stuff
  ys = "Surround",
  yss = "Surround line",
  yS = "Surround till end of line",
  ds = "Delete surrounding",
  dss = "Delete surrounding (line)",
  cs = "Change surrounding",
  css = "Change surrounding (line)",
  ['cst"'] =  "can change an html tag",
  ['cs"\'']  = "changes quotes and parens",
  ['cs)'] = "include space around word",
  ['ds)'] = "delete surround",
  ['2cs"']  = "change outer quotes",
})
