-- https://github.com/snowp/dotfiles/blob/cf5fcc0262c4c7681ede8c6eb2834bbd48693375/config/nvim/lua/plugins/lsp_zero.lua#L121
-- https://github.com/Waterwolf9910/nvim-init.lua/blob/4b60287f69c5dbf8cf310fcc7baf264c88c8100d/lua/plugins/lsp_dap.lua#L110
-- https://github.com/CrumblyLiquid/dotfiles/blob/169d75a2223643da0f4a0855ec015a9f6d62137e/nvim/nvim-old/lua/plug.lua#L194
-- https://github.com/Ivan-Wang-J-W/nvim/blob/b9c81d7329058b0efcf12b9b4de2c5a0fd9783d4/lua/core/plugins.lua#L102
-- https://github.com/jackhwalters/dotfiles/blob/7a7897f32d1e0404f5199ab858249d0fba61d39f/nvim/after/plugin/lsp.lua#L44
-- https://github.com/felipeprov/nvim.config/blob/97c395e6fcb6760b55a2d7d7817b5fd7b98ab6e4/lua/plugins/lsp.lua#L86
-- https://github.com/brw/dotfiles/blob/81acff3c6e18dd73ceed55cd7331ab31cb0a9649/nvim/.config/nvim/lua/plugins.lua#L266
-- https://github.com/nodev19/dotfiles/blob/b871745614121edd3c8044031319c7e17387fdc0/init.lua#L123

-- Enable these language servers
--
-- Add any additional override configuration in the following tables.
-- Available keys are:
-- - cmd (table): Override the default command used to start the server
-- - filetypes (table): Override the default list of associated file types
-- - capabilities (table): Override fields in capabilitied
-- - settings (table): Overrid the default settings passed when
-- initializing the server
local servers = {
  bashls = {},
  dockerls = {},
  clangd = {},
  mesonlsp = {},
  jsonls = {},
  lua_ls = {
    -- Get the language server to recognize the 'vim' global
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
  },
  pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        procMacro = { enable = true },
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  -- tsserver = {},

  yamlls = {
    -- cmd = { "yamls" },
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { "yaml", "yml" },
    -- root_dir = util.find_git_ancestor,
    settings = {
      yaml = {
        -- schemaStore = { enable = true },
        format = { enable = true },
        hover = true,
        completion = true,

        customTags = {
          "!And",
          "!And sequence",
          "!Base64",
          "!Cidr",
          "!Cidr sequence",
          "!Condition",
          "!Equals",
          "!Equals sequence",
          "!FindInMap",
          "!FindInMap sequence",
          "!GetAtt",
          "!GetAZ",
          "!If",
          "!If sequence",
          "!ImportValue",
          "!ImportValue sequence",
          "!Join",
          "!Join sequence",
          "!Not",
          "!Not sequence",
          "!Or",
          "!Or sequence",
          "!Ref",
          "!Select",
          "!Select sequence",
          "!Split",
          "!Split sequence",
          "!Sub",
          "!Sub sequence",
        },
      },
    },
  },
}


-- LSP servers and clients are able to communicate to each other what
-- features they support. By default, neovim doesn't support everything
-- that is in the LSP specfication. When you add nvim-cmp, luasnip, etc.
-- Neovim now has *more* capabilities. So we create new capabilities with
-- nvim_cmp, and then broadast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

vim.diagnostic.config({
  virtual_text = true,
  -- for nightly builds
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

require("neodev").setup({
  -- see https://github.com/rcarriga/nvim-dap-ui
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
-- local lspconfig = require("lspconfig")

require("dapui").setup()

local hl = vim.api.nvim_set_hl
hl(0, "LspInlayHint", { fg = "#d5c4a1", bg = "#504945" })

local lsp_zero = require('lsp-zero')
-- for versions <= 0.9.4
lsp_zero.set_sign_icons({
  error = '✘',
  warn = ' ',
  hint = "",
  info = "",
  -- hint = '⚑',
  -- info = ' '
})
local lsp_util = require("lspconfig.util")
lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require('mason').setup({})

-- You can add other tools here that you want Mason to install for you, so
-- that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    function(server_name)
      local server = servers[server_name] or {}
      -- Handle overriding only values explicitly passed by the server
      -- configuration above. Useful when disabling certain features of an
      -- LSP.
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
  -- handlers = {
  -- lsp_zero.default_setup,
  --   clangd = function()
  --     require("lspconfig").clangd.setup({
  --       keys = { -- TODO: move it to which key
  --         { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
  --       },
  --       root_dir = function(fname)
  --         return require("lspconfig.util").root_pattern(
  --           "Makefile",
  --           "configure.ac",
  --           "configure.in",
  --           "config.h.in",
  --           "meson.build",
  --           "meson_options.txt",
  --           "build.ninja"
  --         )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
  --           fname
  --         ) or require("lspconfig.util").find_git_ancestor(fname)
  --       end,
  --       -- ft = consts.lsp.clangd_fts,
  --       capabilities = {
  --         offsetEncoding = { "utf-16" },
  --       },
  --       cmd = {
  --         "clangd",
  --         '--enable-config',
  --         "--background-index",
  --         -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
  --         -- to add more checks, create .clang-tidy file in the root directory
  --         -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
  --         "--clang-tidy",
  --         -- "--completion-style=bundled",
  --         "--completion-style=detailed",
  --         "--cross-file-rename",
  --         "--header-insertion=iwyu",
  --         "--function-arg-placeholders",
  --         "--fallback-style=llvm",
  --         -- "--pch-storage=memory",
  --         -- "--suggest-missing-includes",
  --         -- "--all-scopes-completion",
  --         "--log=verbose",
  --         "--pretty",
  --       },
  --       init_options = {
  --         usePlaceholders = true,
  --         completeUnimported = true,
  --         clangdFileStatus = true,
  --       },
  --     })
  --   end,
  --   pyright = function()
  --     require("lspconfig").pyright.setup({
  --       capabilities = capabilities,
  --       settings = {
  --         python = {
  --           analysis = {
  --             typeCheckingMode = "on",
  --           },
  --         },
  --       },
  --     })
  --   end,
  --
  --   rust_analyzer = function()
  --     require("lspconfig").rust_analyzer.setup({
  --       capabilities = capabilities,
  --       settings = {
  --         ["rust-analyzer"] = {
  --           check = {
  --             command = "clippy",
  --           },
  --           diagnostics = {
  --             enable = true,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
})
require("mason-nvim-dap").setup({
  automatic_setup = true,
  ensure_installed = {
    'codelldb',
    -- 'node2',
  },

  handlers = {},
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  sources = {
    -- Copilot Source
    { name = "copilot",  group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = "luasnip",  group_index = 2 },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
  },
  -- full format
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      -- return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
      return require('lspkind').cmp_format({
        mode = "symbol",
        max_width = 50,
        symbol_map = { Copilot = "" }
      })(entry, vim_item)
    end
  }
})

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})



-- 1
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end
})
