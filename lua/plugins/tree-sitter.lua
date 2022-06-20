require("nvim-treesitter.configs").setup({
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- FIXME: phpdocs not compilable on M1
    ignore_install = { "phpdocs" },
    highlight = {
        -- false will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
    }
})
