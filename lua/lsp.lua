local vim = vim
local lsp = require("lspconfig")
local coq = require("coq")
local M = {}

local nvim_data_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/"

-- Lsp customization
--
vim.lsp.protocol.CompletionItemKind = {
    " [text]", " [method]", " [function]", " [constructor]", "ﰠ [field]", " [variable]", " [class]", " [interface]",
    " [module]", " [property]", " [unit]", " [value]", " [enum]", " [key]", " [snippet]", " [color]", " [file]",
    " [reference]", " [folder]", " [enum member]", " [constant]", " [struct]", "⌘ [event]", " [operator]", "♛ [type]"
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
local signs = {Error = "", Warn = "", Hint = "", Info = ""}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'LspDiagnosticsDefaultError'})
-- vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'LspDiagnosticsDefaultWarning'})
-- vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'LspDiagnosticsDefaultHint'})
-- vim.fn.sign_define('DiagnosticSignInfo', {text = '', texthl = 'LspDiagnosticsDefaultInformation'})

-- Lsp setup
--
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function common_on_attach(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    --
    -- return M
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Get signatures (and _only_ signatures) when in argument lists.
    require"lsp_signature".on_attach({doc_lines = 0, handler_opts = {border = "none"}})

    if client.server_capabilities.document_formatting then vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()") end
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings {ui = {icons = {server_installed = "✓", server_pending = "➜", server_uninstalled = "✗"}}}
local servers = {"rust_analyzer", "clangd", "bash-language-server", "jsonls", "sumneko_lua", "pyright", "efm", "texlab", 'ltex'}
for _, lang in pairs(servers) do
    local ok, server = lsp_installer.get_server(lang)
    if ok then
        if not server:is_installed() then
            print("Installing " .. lang)
            server:install()
        end
    end
end

-- efm
local luafmt = {formatCommand = "lua-format -i --column-limit=150", formatStdin = true}
local isort = {formatCommand = "isort --quiet -", formatStdin = true}
local yapf = {formatCommand = "yapf --style='{based_on_style: pep8, column_limit: 120}' --quiet", formatStdin = true}

-- JavaScript/React/TypeScript
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local shellcheck = {LintCommand = 'shellcheck -f gcc -x', lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}
local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}
local golint = {lintCommand = "golint", lintIgnoreExitCode = true, lintFormats = {"%f%l:%c: %m"}}
local goimports = {formatCommand = "goimports", formatStdin = true}
local markdownlint = {lintCommand = 'markdownlint -s', lintStdin = true, lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}}

local misspell = {lintCommand = "misspell", lintIgnoreExitCode = true, lintStdin = true, lintFormats = {"%f:%l:%c: %m"}}

local languages = {
    -- tex = {misspell},
    lua = {luafmt},
    go = {golint, goimports},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    ["javascript.jsx"] = {prettier, eslint},
    ["typescript.tsx"] = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {markdownlint},
    python = {isort, yapf},
    sh = {shfmt, shellcheck}
}

local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
local words = {}
for word in io.open(path, "r"):lines() do table.insert(words, word) end

lsp_installer.on_server_ready(function(server)
    local opts = {on_attach = common_on_attach, capabilities = capabilities, flags = {debounce_text_changes = 150}}

    if server.name == "rust-analyzer" then
        opts.completion = {addCallArgumentSnippets = false, postfix = {enable = false}};
        opts.settings = {["rust-analyzer"] = {cargo = {allFeatures = true}}};
    end
    if server.name == "bash-language-server" then
        opts.cmd = {"bash-language-server", "start"};
        opts.filetypes = {"sh", "zsh"};
        opts.root_dir = lsp.util.root_pattern(".git");
    end
    if server.name == "efm" then
        opts.init_options = {documentFormatting = true, codeAction = false};
        opts.filetypes = vim.tbl_keys(languages);
        opts.settings = {rootMarkers = {"package.json", ".git"}, languages = languages, lintDebounce = 500}
    end

    if server.name == "ltex" then
        opts.cmd = {nvim_data_path .. "ltex/ltex-ls/bin/ltex-ls"};
        opts.settings = {
            ltex = {
                language = "en",
                enabled = {"latex", "tex", "bib", "markdown"},
                diagnosticSeverity = "information",
                setenceCacheSize = 2000,
                additionalRules = {enablePickyRules = true, motherTongue = "en"},
                trace = {server = "verbose"},
                disabledRules = {['en-US'] = {'PROFANITY'}},
                dictionary = {['en-US'] = words}

            }
        }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(coq.lsp_ensure_capabilities(opts))
end)

-- set default prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = false,
    -- virtual_text = { prefix = "" },
    signs = true,
    update_in_insert = false
})

return M
