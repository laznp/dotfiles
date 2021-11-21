vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.backspace = "indent,eol,start"
vim.o.autoindent = true
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.fileformat = "unix"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.mouse = 'a'
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.list = true
vim.o.background = "dark"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.laststatus = 2
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.pumheight = 10
vim.g.syntax = "enable"
vim.g.completeopt = "menu,menuone,noselect,noinsert"
vim.cmd("filetype plugin indent on")
vim.cmd("set formatoptions-=cro")
vim.cmd("set complete+=kspell")
vim.cmd("set listchars=tab:•·")
vim.cmd("command! Reload execute 'source ~/.config/nvim/init.lua'")
vim.cmd("command! Vimrc execute ':e ~/.config/nvim/init.lua'")
vim.cmd("command! -nargs=+ NodeMCU lua require('config.nodemcu').load_command(<f-args>)") -- Need Arduino CLI
vim.api.nvim_exec([[
    au BufWritePre,BufRead * :%s/\s\+$//e
    au BufNewFile,BufRead *.ino setf c
]],false)
