-- Based on
-- https://github.com/Hab5/nvim/blob/main/lua/plugins/configs/statusline.lua
-- and https://github.com/smb374/my-nvim-dots/blob/main/lua/plugins/statusline.lua
local colors = require("colors").get()
local lsp = require "feline.providers.lsp"

local section_color = colors.lightbg

local icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

-- local hide_inactive = require("core.utils").load_config().ui.plugin.statusline.hide_inactive
-- local user_statusline_style = require("core.utils").load_config().ui.plugin.statusline.style
local user_statusline_style = 'arrow'
local statusline_style = icon_styles[user_statusline_style]

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

local vim_mode = {
  provider = function()
    return ' '..mode_colors[vim.fn.mode()][1]
  end,

  hl = {
    fg = colors.statusline_bg,
    bg = colors.nord_blue,
  },
  right_sep = {
    str = statusline_style.right,
    hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
    },
  },
  -- left_sep = {
  --   str = statusline_style.left,
  --   hi = {
  --     fg = colors.nord_blue,
  --   },
  -- },
}


local file = {
  provider = {
    name = "file_info",
    opts = {
      type = 'relative-short',
      -- file_readonly_icon = '',
      -- file_modified_icon = '',
      colored_icon = true,
    },
  },
  hl = {
    fg = colors.white,
    bg = colors.lightbg,
  },
  right_sep = {
    str = statusline_style.right,
    hl = { fg = colors.lightbg, bg = colors.lightbg2 },
  },
  -- left_sep = {
  --   str = statusline_style.left,
  --   hi = {
  --     fg = section_color,
  --   },
  -- },
}

local directory = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. dir_name
  end,

  hl = {
    fg = colors.grey_fg2,
    bg = colors.lightbg2,
  },
  right_sep = {
    str = statusline_style.right,
    hi = {
      fg = colors.lightbg2,
      bg = colors.statusline_bg,
    },
  },
}

local git_branch = {
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
  },
  icon = "  ",
}

-- diffRemove
local git_removed = {
  provider = "git_diff_removed",
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
  },
  icon = "  ",
}

-- diffModfified
local git_changed = {
  provider = "git_diff_changed",
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
  },
  icon = "  ",
}

-- diffAdded
local git_added = {
  provider = "git_diff_added",
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
  },
  icon = "  ",
}

local lsp_message = {
  provider = function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    if Lsp then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = {
        "",
        "",
        "",
      }
      local success_icon = {
        "",
        "",
        "",
      }
      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(
          " %%<%s %s %s (%s%%%%) ",
          success_icon[frame + 1],
          title,
          msg,
          percentage
        )
      else
        return string.format(
          " %%<%s %s %s (%s%%%%) ",
          spinners[frame + 1],
          title,
          msg,
          percentage
        )
      end
    end
    return ""
  end,
  hl = { fg = colors.green },
}

local lsp_connected = {
  provider = function()
    if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
    else
      return "  LSP"
    end
  end,

  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

local lsp_errors = {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist "Error"
  end,
  hl = { fg = colors.red },
  icon = "  ",
}

local lsp_warnings = {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist "Warning"
  end,
  hl = { fg = colors.yellow },
  icon = "  ",
}

local lsp_hints = {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist "Hint"
  end,
  hl = { fg = colors.grey_fg2 },
  icon = "  ",
}

local lsp_infos = {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist "Information"
  end,
  hl = { fg = colors.green },
  icon = "  ",
}

local position_icon = {
  left_sep = { str = statusline_style.left, hi = {fg = section_color}},
  provider = "  ",
  hl = {
    fg = colors.black,
    bg = colors.green,
  },
}

local line_percentage = {
  provider = "line_percentage",

  hl = {
    fg = colors.dark_purple,
    bg = section_color,
    style = "bold"
  },

  right_sep = {
    str = statusline_style.right,
    fg = section_color,
  }
}

-- local lsp_right_sep = {
--   provider = statusline_style.right .. " ",
--   hl = {
--     fg = section_color,
--   },
-- }
-- local lsp_left_sep = {
--   provider = statusline_style.left,
--   hl = {
--     fg = section_color,
--   }
-- }

-- local git_right_sep = {
--   provider = function()
--     local git = vim.g.gitsigns_head or vim.b.gitsigns_head
--     if git then
--       return statusline_style.right .. " "
--     else
--       return ""
--     end
--   end,
--   hl = {
--     fg = section_color,
--   },
-- }
-- local git_left_sep = {
--   provider = function()
--     local git = vim.g.gitsigns_head or vim.b.gitsigns_head
--     if git then
--       return " " .. statusline_style.left
--     else
--       return ""
--     end
--   end,
--
--   hl = {
--     fg = section_color,
--   },
-- }


local components = { active = {}, inactive = {} }

----- ACTIVE ------

-- Left
table.insert(components.active, {
  vim_mode,
  file,
  directory,
  lsp_errors,
  lsp_warnings,
  lsp_hints,
  lsp_infos,
})

-- Middle
table.insert(components.active, {
  lsp_message
})

-- Right
table.insert(components.active, {
  lsp_connected,
  git_branch,
  git_removed,
  git_changed,
  git_added,
  position_icon,
  line_percentage
})

----- INACTIVE ------

if (hide_inactive == false) then

  -- Left
  table.insert(components.inactive, {
    file,
    directory
  })

  -- Middle
  table.insert(components.inactive, {})

  -- Right
  table.insert(components.inactive, {
    position_icon,
    line_percentage
  })

end

---------------------

require("feline").setup {
  components = components,

  colors = {
    fg = colors.fg,
    bg = colors.statusline_bg,
  },

  disable = {
    filetypes = { "NvimTree", "packer" },
    buftypes  = { "terminal" },
    bufnames  = { }
  }
}
