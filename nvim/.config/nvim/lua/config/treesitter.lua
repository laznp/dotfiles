require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'python',
        'rust',
        'hcl',
        'lua',
        'vim',
        'dockerfile',
        'terraform',
        'cpp',
        'javascript',
        'yaml'
    },
    indent = {
        enable = true,
        disable = {'python'}
    },
    highlight = {
        enable = true,
        disable = {'gitignore'},
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true
    }
}
