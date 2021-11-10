let mapleader = ' '

" nerdcommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nnoremap <C-/> <Plug>NERDCommenterToggle
vnoremap <C-/> <Plug>NERDCommenterToggle<CR>gv

" nerdtree
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" fzf
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

" split window
nnoremap <leader>v :vsp<CR>
nnoremap <leader>h :sp<CR>
nnoremap <leader>q <C-w>q

" navigate window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" indentation
vnoremap < <gv
vnoremap > >gv

" cursor movement
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" tab buffer movement
nnoremap <silent> <S-TAB> :bp<CR>
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent> <S-q> :bd<CR>

" fold
nnoremap <F6> za

" syntastic
nnoremap <F7> :call ToggleSyntastic()<CR>

" clear search
nnoremap <silent> <CR> :noh<CR><CR>

" autocomplete
inoremap <expr><TAB> pumvisible() ? "<C-n>" : "<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "<C-p>" : "<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" selection left with shift
nnoremap <S-h> v<left>
inoremap <S-left> <esc>v<left>
vnoremap <S-h> <left>

" selection right with shift
nnoremap <S-l> v<right>
inoremap <S-right> <c-o><right><esc>v<right>
vnoremap <S-l> <right>

" template
nnoremap \py :-1read $HOME/.config/nvim/template/py<CR>2jf:a
nnoremap \go :-1read $HOME/.config/nvim/template/go<CR>7ja
nnoremap \html :-1read $HOME/.config/nvim/template/html<CR>3jf>a
