" Download Vim Plug if not exist
let need_to_install_plugins = 0
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let need_to_install_plugins = 1
endif

" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'andrewstuart/vim-kubernetes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'vim-syntastic/syntastic'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
lua require'colorizer'.setup()
