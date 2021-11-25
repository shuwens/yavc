local vim = vim
local lsp = require("lspconfig")
local coq = require("coq")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function common_on_attach(client, bufnr)
    local function buf_set_keymap(...)
	vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
	vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']k', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "C-]", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>Q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000)<CR>', opts)
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
local servers = {
    "rust_analyzer", "clangd", "bash-language-server", "jsonls", "sumneko_lua", "pyright"
}

for _, lang in pairs(servers) do
    local ok, server = lsp_installer.get_server(lang)
    if ok then
        if not server:is_installed() then
            print("Installing " .. lang)
            server:install()
        end
    end
end

lsp_installer.on_server_ready(function(server)
    local opts = {
	debounce_text_changes = 150,
	on_attach = common_on_attach,
	capabilities = capabilities,
    }

    if server.name == "rust-analyzer" then
	opts.completion = {
	    addCallArgumentSnippets = false,
	    postfix = { enable = false }
	};
	opts.settings = {
	    ["rust-analyzer"] = {
		cargo = {
		    allFeatures = true,
		},
	    },
	};
    end
    if server.name == "bash-language-server" then
	opts.cmd = { "bash-language-server", "start" };
	opts.filetypes = { "sh", "zsh" };
	opts.root_dir = lsp.util.root_pattern(".git");
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(coq.lsp_ensure_capabilities(opts))
end)

vim.fn.sign_define(
"LspDiagnosticsSignError",
{ text = "", numhl = "LspDiagnosticsDefaultError" }
)
vim.fn.sign_define(
"LspDiagnosticsSignWarning",
{ text = "", numhl = "LspDiagnosticsDefaultWarning" }
)
vim.fn.sign_define(
"LspDiagnosticsSignInformation",
{ text = "", numhl = "LspDiagnosticsDefaultInformation" }
)
vim.fn.sign_define(
"LspDiagnosticsSignHint",
{ text = "", numhl = "LspDiagnosticsDefaultHint" }
)

-- set default prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
    -- virtual_text = false,
    virtual_text = { prefix = "" },
    signs = true,
    update_in_insert = false,
}
)
