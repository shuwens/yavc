local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
}

-- lsp progress
-- https://github.com/wavded/dotfiles/blob/2cb063ea572a06dc507855847eea3307aaddfa14/nvim/lua/config/status.lua
-- https://github.com/CaeChao/nvim/blob/1f1d28e4dbb28f74780a2bffbb3ceb29cad58057/lua/configs/lualine.lua
-- local function lsp_progress(_, is_active)
--     if not is_active then return "" end
--     local messages = vim.lsp.util.get_progress_messages()
--     if #messages == 0 then return "" end
--     local status = {}
--     for _, msg in pairs(messages) do table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or "")) end
--     local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--     local ms = vim.loop.hrtime() / 1000000
--     local frame = math.floor(ms / 120) % #spinners
--     return table.concat(status, " | ") .. " " .. spinners[frame + 1]
-- end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

require 'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox-material',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch', {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = { color_error = { fg = colors.red }, color_warn = { fg = colors.yellow }, color_info = { fg = colors.cyan } }
            }
        },
        lualine_c = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                shorting_target = 40 -- Shortens path to leave 40 space in the window
            }
        },
        lualine_x = {
            -- lsp_progress,
            { 'diff', diff_color = { added = { fg = colors.green }, modified = { fg = colors.orange }, removed = { fg = colors.red } } }, 'filetype',
            'encoding', 'fileformat'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = { lualine_a = {}, lualine_b = {}, lualine_c = { 'filename' }, lualine_x = { 'location' }, lualine_y = {}, lualine_z = {} },
    tabline = {},
    extensions = {}
}
