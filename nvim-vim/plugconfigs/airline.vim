let g:airline_theme = "onedark"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemode = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#buffers_label = 'Laz'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_filetype_overrides = {'nerdtree': [ get(g:, 'NERDTreeStatusline', ' NERDTree'), '' ]}
let g:airline_skip_empty_sections = 1
let g:airline_section_z = airline#section#create(['%3p%% ', ' %l:%c'])
let g:airline_symbols.modified = ' '
let g:airline_symbols.dirty = ' ﯂'
let g:airline_mode_map = {
	\ '__'     : '-',
	\ 'c'      : '',
	\ 'i'      : '',
	\ 'ic'     : '',
	\ 'ix'     : '',
	\ 'n'      : '',
	\ 'multi'  : 'M',
	\ 'ni'     : '',
	\ 'no'     : '',
	\ 'R'      : '',
	\ 'Rv'     : '',
	\ 's'      : 'S',
	\ 'S'      : 'S',
	\ 't'      : 'T',
	\ 'v'      : '',
	\ 'V'      : '',
\ }
