vim.o.laststatus = 2
require('staline').setup {
	defaults = {
		left_separator  = "",
		right_separator = "",
		line_column     = "[%l/%L] :%c ", -- `:h stl` to see all flags.
		fg              = "#000000",  -- Foreground text color.
		bg              = "#2A2E36",     -- Default background is transparent.
		cool_symbol     = " ",       -- Change this to override defult OS icon.
		full_path       = true,
		font_active     = "none",     -- "bold", "italic", "bold,italic", etc
		true_colors     = true       -- true lsp colors.
	},
	mode_colors = {
		n = "#98C379",
		i = "#61AFEF",
		c = "#E06C75",
		v = "#C678DD",
	},
	mode_icons = {
		n = " ",
		i = " ",
		c = " ",
		v = " ",   -- etc..
	},
	sections = {
		left = { '- ', '-mode', 'left_sep', ' ', 'branch' },
		mid  = { 'file_name' },
		right = { 'cool_symbol','right_sep', '-line_column' }
	}
}
