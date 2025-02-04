local search_cmd = '' -- leaves back to the default (fd > find)
if (vim.fn.executable('fd') == 0) and (vim.fn.executable('rg') == 1) then
    search_cmd = 'rg --files'
end

require('fzf-lua').setup{
    winopts = {
        height  = 0.35,            -- window height
        width   = 1.00,            -- window width
        row     = 0.92,            -- window row position (0=top, 1=bottom)
    },
    files = {
        cmd     = search_cmd,
    }
}

