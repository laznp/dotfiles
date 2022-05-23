require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'python',
        'rust',
        'hcl',
        'lua',
        'vim',
        'dockerfile',
        'yaml'
    },
    indent = {
        enable = true,
        disable = {'python'}
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true
    }
}
