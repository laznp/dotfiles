" Set Indent on File Read and Delete Trailing Space
au BufNewFile,BufRead *.py set autoindent tabstop=4 softtabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.go set autoindent tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.{yaml,yml} set autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.json set autoindent tabstop=4 softtabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.rasi setf css
au BufNewFile,BufRead *.rasi set autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufWritePre,BufRead * :%s/\s\+$//e

" Set color on i3 Configuration
aug i3config_ft_detection
	au!
	au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
	au BufNewFile,BufRead ~/Projects/dotfiles/i3/config set filetype=i3config
	au BufNewFile,BufRead i3/config set filetype=i3config
aug end

