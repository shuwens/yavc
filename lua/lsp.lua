local vim = vim
local lsp = require("lspconfig")
local coq = require("coq")

require("mason").setup()
require("mason-lspconfig").setup()
-- "rust_analyzer", "clangd", "bash-language-server", "jsonls", "sumneko_lua", "pylsp", "ltex", "texlab", 'pyright

local M = {}

local nvim_data_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/"

-- Lsp customization
--
vim.lsp.protocol.CompletionItemKind = {
    " [text]", " [method]", " [function]", " [constructor]", "ﰠ [field]", " [variable]", " [class]",
    " [interface]",
    " [module]", " [property]", " [unit]", " [value]", " [enum]", " [key]", " [snippet]",
    " [color]", " [file]",
    " [reference]", " [folder]", " [enum member]", " [constant]", " [struct]", "⌘ [event]",
    " [operator]", "♛ [type]"
}

M.symbol_kind_icons = {
    Function = "",
    Method = "",
    Variable = "",
    Constant = "",
    Interface = "",
    Field = "ﰠ",
    Property = "",
    Struct = "",
    Enum = "",
    Class = "",
    Snippet = " "
}

M.symbol_kind_colors = {
    Method = "green",
    Variable = "blue",
    Constant = "red",
    Interface = "cyan",
    Field = "blue",
    Property = "blue",
    Struct = "cyan",
    Enum = "yellow",
    Class = "red",
    Snippet = "green"
}

-- Diagnostics symbols for display in the sign column.
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'LspDiagnosticsDefaultError'})
-- vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'LspDiagnosticsDefaultWarning'})
-- vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'LspDiagnosticsDefaultHint'})
-- vim.fn.sign_define('DiagnosticSignInfo', {text = '', texthl = 'LspDiagnosticsDefaultInformation'})

-- Lsp setup

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local group = vim.api.nvim_create_augroup("DocumentFormatting", { clear = true })
local function common_on_attach(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    -- return M
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Get signatures (and _only_ signatures) when in argument lists.
    require "lsp_signature".on_attach({ doc_lines = 0, handler_opts = { border = "none" } })

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
local words = {}
for word in io.open(path, "r"):lines() do table.insert(words, word) end

-- set default prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = false,
    -- virtual_text = { prefix = "" },
    signs = true,
    update_in_insert = false
})

-- null-ls
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    require('null-ls').builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.formatting.prettierd,
  },
})

-- Has to be after calling null-ls
require('mason-null-ls').setup({ automatic_installation = true })


return M
