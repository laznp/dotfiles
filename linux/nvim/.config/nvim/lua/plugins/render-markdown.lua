return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {
        code = {
            sign = false,
            left_pad = 2,
        },
        heading = {
            border = false,
            sign = false,
            position = 'inline',
            icons = { ' ' }
        },
        indent = {
            enabled = false,
            skip_level = 0,
            skip_heading = false,
            render_modes = false,
        },
        checkbox = {
            unchecked = { icon = '✘ ' },
            checked = { icon = '✔ ' },
            custom = { todo = { rendered = '◯ ' } },
        },
        anti_conceal = {
            enabled = false,
        },
        pipe_table = { 
            preset = 'heavy', 
            filler = '',
            head = '',
            row = '',
        },
    },
}
