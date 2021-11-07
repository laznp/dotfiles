let g:polyglot_disabled = ['autoindent']

" base config
exec "source" "~/.config/nvim/settings.vim"
exec "source" "~/.config/nvim/plugins.vim"
exec "source" "~/.config/nvim/keybinds.vim"
exec "source" "~/.config/nvim/autocmd.vim"
exec "source" "~/.config/nvim/utils.vim"

" plugin config
function! Dot(path)
  return "~/.config/nvim/" . a:path
endfunction

for file in split(glob(Dot("plugconfigs/*.vim")), "\n")
  execute "source" file
endfor

