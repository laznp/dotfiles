require("toggleterm").setup{
	size = 10,
	open_mapping = [[<F3>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = '1',
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = 'float',
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = 'single',
		winblend = 5,
		highlights = {
			border = "Normal",
			background = "Normal",
		}
	}
}
