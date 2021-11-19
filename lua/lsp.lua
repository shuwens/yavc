local vim = vim
local lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspinstall").setup() -- important

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

local coq = require("coq")
-- List of installed LSP servers
-- if vim.fn.executable("rust-analyzer") > 0 then
--   lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     },
--     completion = {
--       addCallArgumentSnippets = false,
--       postfix = {
--         enable = false
--       }
--     },
--     settings = {
--       ["rust-analyzer"] = {
--         cargo = {
--           allFeatures = true,
--           },
--         },
--       },
--     capabilities = capabilities,
--     }))
-- end
-- if vim.fn.executable("bash-language-server") == 1 then
--   lsp.bashls.setup(coq.lsp_ensure_capabilities({
--     cmd = {
--       "bash-language-server",
--       "start"
--       },
--     filetypes = {
--       "sh",
--       "zsh"
--       },
--     root_dir = lsp.util.root_pattern(".git"),
--     on_attach = on_attach
--     }))
-- end
-- if vim.fn.executable("pyright") > 0 then
--   lsp.pyright.setup(coq.lsp_ensure_capabilities({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     }))
-- end

-- lspinstall broken?
local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
	local client = lsp[server]
	local config = vim.g.lsp_config[server] or client
	lsp[server].setup(coq.lsp_ensure_capabilities({
		debounce_text_changes = 150,
		on_attach = config.on_attach or common_on_attach,
		settings = config.settings or {},
	}))
end

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
