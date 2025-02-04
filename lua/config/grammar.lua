-- hook to nvim-lspconfig
require("grammar-guard").init()

local nvim_data_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/"
-- setup LSP config
require("lspconfig").grammar_guard.setup({
	cmd = { nvim_data_path .. "ltex/ltex-ls/bin/ltex-ls" }, -- add this if you install ltex-ls yourself
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown" },
			language = "en",
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "en",
			},
			trace = { server = "verbose" },
			dictionary = {},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})
