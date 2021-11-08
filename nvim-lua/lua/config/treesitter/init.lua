require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'c','python','bash','rust',
		'cpp','hcl','lua','vim',
		'go','javascript','css','html'
	},
	indent = {
		enable = true
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true
	}
}
