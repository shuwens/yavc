-- https://github.com/mrkatebzadeh/Siarch/blob/master/nvim/.config/nvim/lua/whichkey_config.lua

local wk = require("which-key")
local g = vim.g
local goto_opts = { wrap = true, float = true }

wk.setup({

    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,
    ---@param mapping wk.Mapping
    filter = function(mapping)
        -- example to exclude mappings without a description
        -- return mapping.desc and mapping.desc ~= ""
        return true
    end,
    --- You can add any mappings here, or use `require('which-key').add()` later
    ---@type wk.Spec
    spec = {},
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- Enable/disable WhichKey for certain mapping modes
    modes = {
        n = true, -- Normal mode
        i = true, -- Insert mode
        x = true, -- Visual mode
        s = true, -- Select mode
        o = true, -- Operator pending mode
        t = true, -- Terminal mode
        c = true, -- Command mode
        -- Start hidden and wait for a key to be pressed before showing the popup
        -- Only used by enabled xo mapping modes.
        -- Set to false to show the popup immediately (after the delay)
        defer = {
            ["<C-V>"] = true,
            V = true,
        },
    },
    plugins = {
        marks = true,     -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true,    -- adds help for operators like d, y, ...
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
        },
    },
    ---@type wk.Win.opts
    win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        -- border = "none",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
            -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
    },
    layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 3,          -- spacing between columns
        align = "left",       -- align columns left, center or right
    },
    keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    ---@type (string|wk.Sorter)[]
    --- Mappings are sorted using configured sorters and natural sort of the keys
    --- Available sorters:
    --- * local: buffer-local mappings first
    --- * order: order of the items (Used by plugins like marks / registers)
    --- * group: groups last
    --- * alphanum: alpha-numerical first
    --- * mod: special modifier keys last
    --- * manual: the order the mappings were added
    --- * case: lower-case first
    sort = { "local", "order", "group", "alphanum", "mod" },
    ---@type number|fun(node: wk.Node):boolean?
    expand = 0, -- expand groups when <= n mappings
    -- expand = function(node)
    --   return not node.desc -- expand all nodes without a description
    -- end,
    ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
    replace = {
        key = {
            function(key)
                return require("which-key.view").format(key)
            end,
            -- { "<Space>", "SPC" },
        },
        desc = {
            { "<Plug>%(?(.*)%)?", "%1" },
            { "^%+",              "" },
            { "<[cC]md>",         "" },
            { "<[cC][rR]>",       "" },
            { "<[sS]ilent>",      "" },
            { "^lua%s+",          "" },
            { "^call%s+",         "" },
            { "^:%s*",            "" },
        },
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        ellipsis = "…",
        -- set to false to disable all mapping icons,
        -- both those explicitely added in a mapping
        -- and those from rules
        mappings = true,
        --- See `lua/which-key/icons.lua` for more details
        --- Set to `false` to disable keymap icons from rules
        ---@type wk.IconRule[]|false
        rules = {},
        -- use the highlights from mini.icons
        -- When `false`, it will use `WhichKeyIcon` instead
        colors = true,
        -- used by key format
        keys = {
            Up = " ",
            Down = " ",
            Left = " ",
            Right = " ",
            C = "󰘴 ",
            M = "󰘵 ",
            D = "󰘳 ",
            S = "󰘶 ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫",
            F2 = "󱊬",
            F3 = "󱊭",
            F4 = "󱊮",
            F5 = "󱊯",
            F6 = "󱊰",
            F7 = "󱊱",
            F8 = "󱊲",
            F9 = "󱊳",
            F10 = "󱊴",
            F11 = "󱊵",
            F12 = "󱊶",
        },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- Which-key automatically sets up triggers for your mappings.
    -- But you can disable this and setup the triggers yourself.
    -- Be aware, that triggers are not needed for visual and operator pending mode.
    triggers = true, -- automatically setup triggers
    disable = {
        -- disable WhichKey for certain buf types and file types.
        ft = {},
        bt = {},
        -- disable a trigger for a certain context by returning true
        ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
        trigger = function(ctx)
            return false
        end,
    },
    debug = false, -- enable wk.log in the current directory


    -- plugins = {
    --     marks = true,     -- shows a list of your marks on ' and `
    --     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --     -- No actual key bindings are created
    --     spelling = {
    --         enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --         suggestions = 20 -- how many suggestions should be shown in the list?
    --     },
    --     presets = {
    --         operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --         motions = true,      -- adds help for motions
    --         text_objects = true, -- help for text objects triggered after entering an operator
    --         windows = true,      -- default bindings on <c-w>
    --         nav = true,          -- misc bindings to work with windows
    --         z = true,            -- bindings for folds, spelling and others prefixed with z
    --         g = true             -- bindings for prefixed with g
    --     }
    -- },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    -- icons = {
    --     breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    --     separator = "➜", -- symbol used between a key and it's label
    --     group = "+" -- symbol prepended to a group
    -- },
    -- window = {
    --     border = "none",         -- none, single, double, shadow
    --     position = "bottom",     -- bottom, top
    --     margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    --     padding = { 2, 2, 2, 2 } -- extra window padding [top, right, bottom, left]
    -- },
    -- layout = {
    --     height = { min = 4, max = 25 },                                           -- min and max height of the columns
    --     width = { min = 20, max = 50 },                                           -- min and max width of the columns
    --     spacing = 3                                                               -- spacing between columns
    -- },
    -- ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
    -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    -- show_help = true,                                                             -- show help message on the command line when the popup is visible
    -- triggers = "auto"                                                             -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specifiy a list manually
})


wk.add({
    --     { "<leader>f",  group = "file" }, -- group
    --     { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    --     { "<leader>fb", function() print("hello") end,   desc = "Foobar" },
    --     { "<leader>fn", desc = "New File" },
    --     { "<leader>f1", hidden = true }, -- hide this keymap
    --     {
    --         -- Nested mappings are allowed and can be added in any order
    --         -- Most attributes can be inherited or overridden on any level
    --         -- There's no limit to the depth of nesting
    --         mode = { "n", "v" },                      -- NORMAL and VISUAL mode
    --         { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    --         { "<leader>w", "<cmd>w<cr>", desc = "Write" },
    --     }
    { "<leader> ",   "<c-^>",                                                                        desc = "Jump to last" },
    { "<leader>D",   ":Dispatch<CR>",                                                                desc = "Dispatch" },
    { "<leader>Q",   "g<c-g>",                                                                       desc = "Show stats" },
    { "<leader>W",   group = "windows" },
    { "<leader>W-",  "<C-W>s",                                                                       desc = "split-window-below" },
    { "<leader>W2",  "<C-W>v",                                                                       desc = "layout-double-columns" },
    { "<leader>W=",  "<C-W>=",                                                                       desc = "balance-window" },
    { "<leader>W?",  "Windows",                                                                      desc = "fzf-window" },
    { "<leader>WH",  "<C-W>5<",                                                                      desc = "expand-window-left" },
    { "<leader>WJ",  ":resize +5<CR>",                                                               desc = "expand-window-below" },
    { "<leader>WK",  ":resize -5<CR>",                                                               desc = "expand-window-up" },
    { "<leader>WL",  "<C-W>5>",                                                                      desc = "expand-window-right" },
    { "<leader>Wd",  "<C-W>c",                                                                       desc = "delete-window" },
    { "<leader>Wh",  "<C-W>h",                                                                       desc = "window-left" },
    { "<leader>Wj",  "<C-W>j",                                                                       desc = "window-below" },
    { "<leader>Wk",  "<C-W>k",                                                                       desc = "window-up" },
    { "<leader>Wl",  "<C-W>l",                                                                       desc = "window-right" },
    { "<leader>Ws",  "<C-W>s",                                                                       desc = "split-window-below" },
    { "<leader>Wv",  "<C-W>v",                                                                       desc = "split-window-below" },
    { "<leader>Ww",  "<C-W>w",                                                                       desc = "other-window" },
    { "<leader>W|",  "<C-W>v",                                                                       desc = "split-window-right" },
    { "<leader>b",   group = "Buffer" },
    { "<leader>bB",  ":BufferPick<CR>",                                                              desc = "fzf-buffer pick" },
    { "<leader>bb",  ":Buffers<CR>",                                                                 desc = "fzf-buffer" },
    { "<leader>bg",  ":Gitsigns toggle_current_line_blame<CR>",                                      desc = "Show blame for line" },
    { "<leader>bl",  ":BufferLinePick<CR>",                                                          desc = "buffer line pick" },
    { "<leader>bn",  ":bnext<CR>",                                                                   desc = "next-buffer" },
    { "<leader>bp",  ":bprevious<CR>",                                                               desc = "previous-buffer" },
    { "<leader>c",   group = "QuickFix List" },
    { "<leader>cG",  "<cmd>:clast<CR>",                                                              desc = "Last item in QuickFix list" },
    { "<leader>cN",  "<cmd>:cp<CR>",                                                                 desc = "Prev item in QuickFix list" },
    { "<leader>cg",  "<cmd>:cfirst<CR>",                                                             desc = "First item in QuickFix list" },
    { "<leader>cn",  "<cmd>:cn<CR>",                                                                 desc = "Next item in QuickFix list" },
    { "<leader>cq",  "<cmd>:cclose<CR>",                                                             desc = "Close QuickFix list" },
    { "<leader>ct",  "<cmd>:TodoQuickFix<CR>",                                                       desc = "Open TODO QuickFix list" },
    { "<leader>d",   group = "Debug List" },
    { "<leader>db",  ":lua require'dap'.toggle_breakpoint() <CR>",                                   desc = "Set breakpoint" },
    { "<leader>dg",  ":DapUiToggle <CR>",                                                            desc = "Toggle DAP GUI" },
    { "<leader>dn",  ":lua require'dap'.step_over() <CR>",                                           desc = "Step" },
    { "<leader>f",   group = "Fuzzy Search" },
    { "<leader>fb",  "<cmd>lua require('telescope.builtin').buffers()<CR>",                          desc = "buffer" },
    { "<leader>ff",  "<cmd>lua require('telescope.builtin').find_files()<CR>",                       desc = "file" },
    { "<leader>fg",  "<cmd>lua require('telescope.builtin').live_grep()<CR>",                        desc = "Live grep" },
    { "<leader>fh",  "<cmd>lua require('telescope.builtin').help_tags()<CR>",                        desc = "Help tags" },
    { "<leader>g",   group = "Git/Grammar" },
    { "<leader>gg",  ":GrammarousCheck --lang=en-US --preview<CR>",                                  desc = "Grammar check" },
    { "<leader>gl",  ":LazyGit<CR>",                                                                 desc = "Lazy Git" },
    { "<leader>gm",  "<ESC>/\v^[<=>]{7}( .*\\|$)<CR>",                                               desc = "Merge Conflict" },
    { "<leader>l",   group = "lsp" },
    { "<leader>lI",  ":LspInfo<CR>",                                                                 desc = "lsp info" },
    { "<leader>lT",  ":lua vim.lsp.buf.type_definition()<CR>",                                       desc = "type defintion" },
    { "<leader>lf",  ":lua vim.lsp.buf.format({async = true})<CR>",                                  desc = "format" },
    { "<leader>lg",  group = "goto" },
    { "<leader>lgd", ":LspDefinition<CR>",                                                           desc = "Goto Definition" },
    { "<leader>lgi", ":LspImplementation<CR>",                                                       desc = "Goto Implementation" },
    { "<leader>lgr", ":LspReferences<CR>",                                                           desc = "Goto References" },
    { "<leader>lgy", ":LspTypeDefinition<CR>",                                                       desc = "Goto Type Definition" },
    { "<leader>lo",  ":lua vim.diagnostic.open_float()<CR>",                                         desc = "lsp open float" },
    { "<leader>lv",  ":LspVirtualTextToggle<CR>",                                                    desc = "lsp toggle virtual text" },
    { "<leader>lx",  ":cclose<CR>",                                                                  desc = "close quickfix" },
    { "<leader>t",   group = "TODO in comments" },
    { "<leader>tl",  ":TodoLocList<CR>",                                                             desc = "TODO location list" },
    { "<leader>tn",  "<cmd>lua require('todo-comments').jump_next()<CR>",                            desc = "Next todo comment" },
    { "<leader>tp",  "<cmd>lua require('todo-comments').jump_prev()<CR>",                            desc = "Previous todo comment" },
    { "<leader>tq",  ":TodoQuickFix<CR>",                                                            desc = "TODO quickfix list" },
    { "<leader>tt",  ":TodoTelescope<CR>",                                                           desc = "TODO search with Telescope" },
    { "<leader>u",   ":UndotreeToggle<CR>",                                                          desc = "Undo Tree" },
    { "<leader>v",   group = "Lsp" },
    { "<leader>vD",  "<cmd>lua vim.lsp.buf.declaration()<CR>",                                       desc = "Goto Declaration" },
    { "<leader>vc",  group = "Code Action" },
    { "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>",                                       desc = "Code Actions" },
    { "<leader>vcc", '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>',                  desc = "Line Diagnostics" },
    { "<leader>vd",  "<cmd>lua vim.lsp.buf.definition()<CR>",                                        desc = "Goto Definition" },
    { "<leader>vg",  group = "goto" },
    { "<leader>vgd", ":LspDefinition<CR>",                                                           desc = "Goto Definition" },
    { "<leader>vgi", ":LspImplementation<CR>",                                                       desc = "Goto Implementation" },
    { "<leader>vgr", ":LspReferences<CR>",                                                           desc = "Goto References" },
    { "<leader>vgt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",                                   desc = "Goto type def" },
    { "<leader>vgy", ":LspTypeDefinition<CR>",                                                       desc = "Goto Type Definition" },
    { "<leader>vh",  "<cmd>lua vim.lsp.buf.hover()<CR>",                                             desc = "Hover Documentation" },
    { "<leader>vi",  "<cmd>lua vim.lsp.buf.implementation()<CR>",                                    desc = "Goto Implementation" },
    { "<leader>vl",  "<cmd>lua LspLocationList()<CR>",                                               desc = "Lsp Location" },
    { "<leader>vn",  "<cmd>lua vim.diagnostic.goto_next({wrap = true, float = false})<CR>",          desc = "Goto Next Diagnostics" },
    { "<leader>vr",  group = "Reference / Rename" },
    { "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>",                                            desc = "Rename" },
    { "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>",                                        desc = "Reference" },
    { "<leader>vs",  "<cmd>lua vim.lsp.buf.signature_help()<CR>",                                    desc = "Signature help" },
    { "<leader>w",   ":StripWhitespace<CR>:w<CR>",                                                   desc = "Write and rm space" },
    { "<leader>z",   group = "Zettelkasten" },
    { "<leader>zb",  "<Cmd>ZkBacklinks<CR>",                                                         desc = "Back links" },
    { "<leader>zd",  group = "Daily Notes" },
    { "<leader>zdt", "<cmd>ZkNew { dir = 'journal/daily', date = 'today' }<cr>",                     desc = "Today",                                                     remap = false },
    { "<leader>zdy", "<cmd>ZkNew { dir = 'journal/daily', date = 'yesterday' }<cr>",                 desc = "Yesterday",                                                 remap = false },
    { "<leader>zf",  "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<cr>", desc = "Find Notes",                                                remap = false },
    { "<leader>zn",  "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>",                           desc = "New Note",                                                  remap = false },
    { "<leader>zo",  "<cmd>ZkNotes { sort = { 'modified' } }<cr>",                                   desc = "Open Notes",                                                remap = false },
    { "<leader>zs",  ":'<,'>ZkMatch<CR>",                                                            desc = "Search for the notes matching the current visual selection" },
    { "<leader>zt",  "<cmd>ZkTags<cr>",                                                              desc = "Open by Tag",                                               remap = false },


})

-- wk.register({
--     [" "] = { '<c-^>', "Jump to last" },
--     -- ["<CR>"] = "Open Terminal (Buffer)",
--     -- ["`"] = "Open Terminal (Horizontal)",
--     -- a = "Select all",
--     -- <leader><leader> toggles between buffers
--     b = {
--         name = '+Buffer',
--         b = { ':Buffers<CR>', 'fzf-buffer' },
--         g = { ':Gitsigns toggle_current_line_blame<CR>', "Show blame for line" },
--         -- d = {':BufferClose<CR>'               , 'delete-buffer'},
--         n = { ':bnext<CR>', 'next-buffer' },
--         p = { ':bprevious<CR>', 'previous-buffer' },
--         l = { ':BufferLinePick<CR>', 'buffer line pick' },
--         B = { ':BufferPick<CR>', 'fzf-buffer pick' }
--     },
--     c = {
--         name = "+QuickFix List",
--         n = { "<cmd>:cn<CR>", "Next item in QuickFix list" },
--         N = { "<cmd>:cp<CR>", "Prev item in QuickFix list" },
--         q = { "<cmd>:cclose<CR>", "Close QuickFix list" },
--         g = { "<cmd>:cfirst<CR>", "First item in QuickFix list" },
--         G = { "<cmd>:clast<CR>", "Last item in QuickFix list" },
--         t = { "<cmd>:TodoQuickFix<CR>", "Open TODO QuickFix list" }
--     },
--     d = {
--         name = "+Debug List",
--         b = { ":lua require'dap'.toggle_breakpoint() <CR>", "Set breakpoint" },
--         g = { ":DapUiToggle <CR>", "Toggle DAP GUI" },
--         n = { ":lua require'dap'.step_over() <CR>", "Step" },
--     },
--     D = { ':Dispatch<CR>', "Dispatch" },
--     -- f = {
--     --     name = "+Fuzzy Search",
--     --     f = {"<cmd>lua require('fzf-lua').files()<CR>", "file"},
--     --     b = {"<cmd>lua require('fzf-lua').buffers()<CR>", "buffer"},
--     --     q = {"<cmd>lua require('fzf-lua').quickfix()<CR>", "quickfix"},
--     --     l = {"<cmd>lua require('fzf-lua').loclist()<CR>", "loc list"},
--     --     p = {"<cmd>lua require('fzf-lua').grep_project()<CR>", "Rg project"},
--     --     w = {"<cmd>lua require('fzf-lua').grep_cword()<CR>", "Current word"},
--     --     g = {"<cmd>lua require('fzf-lua').live_grep_native()<CR>", "Live grep"},
--     --     c = {"<cmd>lua require('fzf-lua').git_commits()<CR>", "Git commits"}
--     -- },
--     f = {
--         name = "+Fuzzy Search",
--         f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "file" },
--         b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "buffer" },
--         g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live grep" },
--         h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help tags" }
--         -- q = {"<cmd>lua require('fzf-lua').quickfix()<CR>", "quickfix"},
--         -- l = {"<cmd>lua require('fzf-lua').loclist()<CR>", "loc list"},
--         -- p = {"<cmd>lua require('fzf-lua').grep_project()<CR>", "Rg project"},
--         -- w = {"<cmd>lua require('fzf-lua').grep_cword()<CR>", "Current word"},
--         -- c = {"<cmd>lua require('fzf-lua').git_commits()<CR>", "Git commits"}
--     },
--     --     " Find files using Telescope command-line sugar.
--     -- nnoremap <leader>ff <cmd>Telescope find_files<cr>
--     -- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
--     -- nnoremap <leader>fb <cmd>Telescope buffers<cr>
--     -- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
--     --
--     -- " Using Lua functions
--     -- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--     -- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--     -- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--     -- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
--     g = {
--         name = "+Git/Grammar",
--         g = { ':GrammarousCheck --lang=en-US --preview<CR>', "Grammar check" },
--         m = { "<ESC>/\v^[<=>]{7}( .*\\|$)<CR>", "Merge Conflict" },
--         l = { ':LazyGit<CR>', "Lazy Git" }
--     },
--     -- h = {':TroubleToggle<CR>', "Errors Dashboard"},
--     l = {
--         name = '+lsp',
--         f = { ':lua vim.lsp.buf.format({async = true})<CR>', 'format' },
--         I = { ':LspInfo<CR>', 'lsp info' },
--         o = { ':lua vim.diagnostic.open_float()<CR>', 'lsp open float' },
--         v = { ':LspVirtualTextToggle<CR>', 'lsp toggle virtual text' },
--         T = { ':lua vim.lsp.buf.type_definition()<CR>', 'type defintion' },
--         x = { ':cclose<CR>', 'close quickfix' },
--         g = {
--             name = '+goto',
--             d = { ':LspDefinition<CR>', 'Goto Definition' },
--             y = { ':LspTypeDefinition<CR>', 'Goto Type Definition' },
--             i = { ':LspImplementation<CR>', 'Goto Implementation' },
--             r = { ':LspReferences<CR>', 'Goto References' }
--         }
--     },
--     Q = { 'g<c-g>', "Show stats" },
--     -- n = "Explorer",
--     -- s = { ':set spell!<CR>', "Spell checks" },
--     t = {
--         name = '+TODO in comments',
--         n = { "<cmd>lua require('todo-comments').jump_next()<CR>", "Next todo comment" },
--         p = { "<cmd>lua require('todo-comments').jump_prev()<CR>", "Previous todo comment" },
--         q = { ':TodoQuickFix<CR>', 'TODO quickfix list' },
--         l = { ':TodoLocList<CR>', 'TODO location list' },
--         t = { ':TodoTelescope<CR>', 'TODO search with Telescope' },
--     },
--     u = { ':UndotreeToggle<CR>', "Undo Tree" },
--     v = {
--         name = "+Lsp",
--         d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Goto Definition" },
--         D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Goto Declaration" },
--         i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "Goto Implementation" },
--         h = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover Documentation" },
--         s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help" },
--         l = { '<cmd>lua LspLocationList()<CR>', "Lsp Location" },
--         n = { '<cmd>lua vim.diagnostic.goto_next({wrap = true, float = false})<CR>', "Goto Next Diagnostics" },
--         r = {
--             name = "Reference / Rename",
--             r = { '<cmd>lua vim.lsp.buf.references()<CR>', "Reference" },
--             n = { '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename" }
--         },
--         c = {
--             name = "+Code Action",
--             a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Actions" },
--             c = { '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>', "Line Diagnostics" }
--             -- d = {'<cmd>lua vim.diagnostic.show_cursor_diagnostics()<CR>', "Line Diagnostics"},
--         },
--         g = {
--             name = '+goto',
--             t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Goto type def' },
--             d = { ':LspDefinition<CR>', 'Goto Definition' },
--             y = { ':LspTypeDefinition<CR>', 'Goto Type Definition' },
--             i = { ':LspImplementation<CR>', 'Goto Implementation' },
--             r = { ':LspReferences<CR>', 'Goto References' }
--         }
--     },
--     w = { ':StripWhitespace<CR>:w<CR>', "Write and rm space" },
--     W = {
--         name = '+windows',
--         w = { '<C-W>w', 'other-window' },
--         d = { '<C-W>c', 'delete-window' },
--         ['-'] = { '<C-W>s', 'split-window-below' },
--         ['|'] = { '<C-W>v', 'split-window-right' },
--         ['2'] = { '<C-W>v', 'layout-double-columns' },
--         h = { '<C-W>h', 'window-left' },
--         j = { '<C-W>j', 'window-below' },
--         l = { '<C-W>l', 'window-right' },
--         k = { '<C-W>k', 'window-up' },
--         H = { '<C-W>5<', 'expand-window-left' },
--         J = { ':resize +5<CR>', 'expand-window-below' },
--         L = { '<C-W>5>', 'expand-window-right' },
--         K = { ':resize -5<CR>', 'expand-window-up' },
--         ['='] = { '<C-W>=', 'balance-window' },
--         s = { '<C-W>s', 'split-window-below' },
--         v = { '<C-W>v', 'split-window-below' },
--         ['?'] = { 'Windows', 'fzf-window' }
--     },
--     z = {
--         name = '+Zettelkasten',
--         n = { "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", "New Note", noremap = true, silent = true },
--         o = { "<cmd>ZkNotes { sort = { 'modified' } }<cr>", "Open Notes", noremap = true, silent = true },
--         b = { "<Cmd>ZkBacklinks<CR>", 'Back links' },
--         t = { "<cmd>ZkTags<cr>", "Open by Tag", noremap = true, silent = true },
--         s = { ":'<,'>ZkMatch<CR>", 'Search for the notes matching the current visual selection' },
--         f = {
--             "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<cr>",
--             "Find Notes",
--             noremap = true,
--             silent = true
--         },
--         -- f = { "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", 'Search for the notes matching a given query' },
--         d = {
--             name = "Daily Notes",
--             -- t = { "<Cmd>ZkNotes { sort = { 'modified' }, hrefs = { 'journal/daily' } }<CR>", "Today", noremap = true, silent = true },
--             t = { "<cmd>ZkNew { dir = 'journal/daily', date = 'today' }<cr>", "Today", noremap = true, silent = true },
--             y = { "<cmd>ZkNew { dir = 'journal/daily', date = 'yesterday' }<cr>", "Yesterday", noremap = true, silent = true },
--         }
--     },
-- }, { prefix = g.mapleader })
