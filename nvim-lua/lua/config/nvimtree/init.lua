vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_symlink_arrow = '->'
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
	default = '',
	symlink = '',
	git = {
		unstaged = "",
		staged = "",
		unmerged = "",
		renamed = "➜",
		untracked = "﯂",
		deleted = "",
		ignored = ""
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	}
}
require'nvim-tree'.setup({
	open_on_tab = false,
	update_to_buf_dir   = {
		enable = false,
		auto_open = false,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = true,
		side = 'left',
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {}
		}
	}
})
