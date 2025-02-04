require("wrapping-paper").setup({
	width = math.huge, -- max width of the wrap window
	remaps = {
		-- { "mode", "lhs", "rhs" }, -- these are added to the buffer on open, and removed on close
		{ "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true } },
		{ "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } }, -- This isn't really how it's done, the real mapping for k is more complicated, but it will function like this
		{ "n", "0", "g0" },
		{ "n", "_", "g0" },
		{ "n", "^", "g^" },
		{ "v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true } },
		{ "v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } }, -- same as normal mode k ^
		{ "v", "0", "g0" },
		{ "v", "_", "g0" },
		{ "v", "^", "g^" },

		-- NOTE: these functions are called when the cursor is still in the parent window
		-- remap <c-d> and <c-u>, otherwise they scroll half the popup height which is not what you
		-- expect to happen
		function()
			return { "n", "<c-d>", math.floor(vim.api.nvim_win_get_height(0) / 2) .. "j" }
		end,
		function()
			return { "n", "<c-u>", math.floor(vim.api.nvim_win_get_height(0) / 2) .. "k" }
		end,
		{
			"n",
			"<c-e>",
			function()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local keys = vim.api.nvim_replace_termcodes(
					":q<CR><C-e>:lua require('wrapping-paper').wrap_line()<CR>",
					true,
					false,
					true
				)
				vim.api.nvim_feedkeys(keys, "n", false)
				vim.api.nvim_win_set_cursor(0, cursor)
			end,
		},
		{
			"n",
			"<c-y>",
			function()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local keys = vim.api.nvim_replace_termcodes(
					":q<CR><C-y>:lua require('wrapping-paper').wrap_line()<CR>",
					true,
					false,
					true
				)
				vim.api.nvim_feedkeys(keys, "n", false)
				vim.api.nvim_win_set_cursor(0, cursor)
			end,
		},
	},
})

vim.keymap.set(
	"n",
	"gww", -- see :h gw to figure out why this makes sense.
	require("wrapping-paper").wrap_line,
	{ desc = "fake wrap current line" }
)
