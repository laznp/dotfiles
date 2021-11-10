vim.o.showtabline = 2
--require('stabline').setup {
	--defaults = {
		--style       = "bubble", -- others: arrow, slant, bubble
		--stab_left   = " ",   -- 😬
		--stab_right  = " ",
		----fg          = Default is fg of "Normal".
		----bg          = Default is bg of "Normal".
		--inactive_bg = "#1e2127",
		--inactive_fg = "#aaaaaa",
		----stab_bg     = Default is darker version of bg.,

		--font_active = "bold",
		--exclude_fts = {'NvimTree', 'dashboard', 'lir'},
		--stab_start  = "",   -- The starting of stabline
		--stab_end    = ""
	--},
--}

require'stabline'.setup {
	style = "bubble",
	bg = "#98C379",
	fg = "black",
	exclude_fts = {'NvimTree', 'dashboard', 'lir'},
	font_active = "none",
	--stab_left = "",
	--stab_right = "",
	stab_bg = "#282C34",
	inactive_bg = "#282C34",
	inactive_fg = "#98C379",

}
