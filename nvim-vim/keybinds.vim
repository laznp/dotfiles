let mapleader = ' '

" nerdcommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nnoremap <C-/> <Plug>NERDCommenterToggle
vnoremap <C-/> <Plug>NERDCommenterToggle<CR>gv

" nerdtree
nnoremap <F2> :NERDTreeToggle<CR>

" fzf
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>

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
nnoremap <S-TAB> :bp<CR>
nnoremap <TAB> :bn<CR>
nnoremap <leader>w :bd<CR>

" fold
nnoremap <F6> za

" syntastic
nnoremap <F7> :call ToggleSyntastic()<CR>

" clear search
nnoremap <silent> <CR> :noh<CR><CR>

" autocomplete
inoremap <expr><TAB> pumvisible() ? "<C-n>" : "<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "<C-p>" : "<TAB>"


" template
nnoremap \py :-1read $HOME/.config/nvim/template/py<CR>2jf:a
nnoremap \go :-1read $HOME/.config/nvim/template/go<CR>7ja
nnoremap \html :-1read $HOME/.config/nvim/template/html<CR>3jf>a
