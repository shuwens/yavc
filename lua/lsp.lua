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
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    clangd = function()
      require("lspconfig").clangd.setup({
        keys = { -- TODO: move it to which key
          { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
          fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end, 
        -- ft = consts.lsp.clangd_fts,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          '--enable-config',
          "--background-index",
          -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
          -- to add more checks, create .clang-tidy file in the root directory
          -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
          "--clang-tidy",
          -- "--completion-style=bundled",
          "--completion-style=detailed",
          "--cross-file-rename",
          "--header-insertion=iwyu",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          -- "--pch-storage=memory",
          -- "--suggest-missing-includes",
          -- "--all-scopes-completion",
          "--log=verbose",
          "--pretty",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
    end,

    cmake = function()
      require("lspconfig").cmake.setup({ capabilities = capabilities })
    end,

    dockerls = function()
      require("lspconfig").dockerls.setup({ capabilities = capabilities })
    end,

    pyright = function()
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "on",
            },
          },
        },
      })
    end,

    rust_analyzer = function()
      require("lspconfig").rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
            diagnostics = {
              enable = true,
            },
          },
        },
      })
    end,
  },
  ensure_installed = {
    "lua_ls", --brew install lua-language-server
    "rust_analyzer", --brew install rust-analyzer
    "tsserver", -- yarn global add tsserver
    "clangd",
    "pyright",
    -- "bashls",
    "terraformls",
    "tflint",
  },
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
      return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
    end
  }

})

