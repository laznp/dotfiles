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
    },
    indent = {
        enable = true,
        disable = {'python'}
    },
    highlight = {
        enable = true,
        disable = {'yaml','gitignore'},
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true
    }
}
