set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
let g:syntastic_python_flake8_post_args="--max-line-length=120"
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_quiet_messages = { 'regex': 'W191\|E117\|E265\|E302\|E305\|E501\|E231\|E225' }
let g:syntastic_quiet_messages = { 'regex': 'E501' }
function! ToggleSyntastic()
	for i in range(1, winnr('$'))
		let bnum = winbufnr(i)
		if getbufvar(bnum, '&buftype') == 'quickfix'
			lclose
			return
		endif
	endfor
	SyntasticCheck
endfunction

