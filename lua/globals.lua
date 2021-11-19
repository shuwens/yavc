local g = vim.g

-- Ignore for indent levels
g.indent_blankline_filetype_exclude = {
  "help",
  "packer",
  "dashboard",
  "nvim-tree",
}

-- Ignore for indent levels
g.indent_blankline_buftype_exclude = { "terminal", "nofile" }

g.mapleader = " "
g.maplocalleader = ","

-- extra plugins to install (must only be strings)
g.kyoto_extra_plugins = {}

-- Configs for LSPs
g.lsp_config = {
  lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}

-- UI CONFIGS
-- g.ui = {
--   -- find a list of themes at https://github.com/NvChad/nvim-base16.lua/tree/master/lua/themes
--   theme = "gruvbox",
--   -- Find a list of options at lua/statusline.lua(icon_styles var)
--   statusline_style = "arrow",
--   -- transparent = true,
-- }

-- better whitespace
-- red #FF0000, coral #FF7F50, tomato #FF6347, orangered #FF4500, orange #FFA500, darkorange #FF8C00
g.better_whitespace_guicolor = '#FF4500'
g.better_whitespace_enabled = 1
g.strip_whitespace_on_save = 0

-- Don't confirm .lvimrc
g.localvimrc_ask = 0

g['rustfmt_autosave'] = 1 -- Format on save

-- uncomment this out if you are experiencing issues with nvim-tree.lua
-- g.nvim_tree_git_hl = 0
-- g.nvim_tree_gitignore = 0
-- g.nvim_tree_show_icons = {
--   git = 0,
--   folders = 1,
--   files = 1
-- }
