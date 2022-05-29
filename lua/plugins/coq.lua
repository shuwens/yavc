local g = vim.g

g.coq_settings = {
	auto_start = "shut-up",
	clients = {
		lsp = { short_name = "LSP" },
		snippets = { enabled = true },
		-- too slow in big repo. coq uses a slow version
		tabnine = { enabled = false },
		paths = { preview_lines = 6 },
		tree_sitter = { enabled = true },
		buffers = {
			match_syms = true,
			-- Filter matches only from the same filetype buffers.
			same_filetype = true,
			short_name = "B",
		},
		tags = { enabled = false },
		tmux = { enabled = false },
	},

	keymap = {
		recommended = true,
		-- manual_complete = '<c-space>',
		-- bigger_preview  = '<c-l>',
		-- jump_to_mark    = '<c-w>'
	},

	display = {
		ghost_text = {
			enabled = true,
			context = { " 〈 ", " 〉" },
			highlight_group = 'Comment',
		},

		pum = {
			kind_context = { '  ', '' }, -- {" [", "]"}
		},

		icons = {
			mode = 'short',
			mappings = {
				Boolean       = "",
				Character     = "",
				Class         = "ﴯ",
				Color         = "",
				Constant      = "",
				Constructor   = "",
				Enum          = "",
				EnumMember    = "",
				Event         = "",
				Field         = "ﰠ",
				File          = "",
				Folder        = "ﱮ",
				Function      = "",
				Interface     = "",
				Keyword       = "",
				Method        = "",
				Module        = "",
				Number        = "",
				Operator      = "",
				Parameter     = "ﬦ",
				Property      = "ﰠ",
				Reference     = "",
				Snippet       = "",
				String        = "",
				Struct        = "פּ",
				Text          = "",
				TypeParameter = "",
				Unit          = "塞",
				Value         = "",
				Variable      = "" },
		}
	}
}
