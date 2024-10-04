return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
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
                'c',
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
    end
}
