vim.o.number          = true
vim.o.relativenumber  = false
vim.o.tabstop         = 4
vim.o.shiftwidth      = 4
vim.o.expandtab       = true
vim.o.backspace       = "indent,eol,start"
vim.o.autoindent      = true
vim.o.showmatch       = true
vim.o.incsearch       = true
vim.o.hlsearch        = true
vim.o.fileformat      = "unix"
vim.o.encoding        = "utf-8"
vim.o.fileencoding    = "utf-8"
vim.o.mouse           = 'a'
vim.o.foldmethod      = "indent"
vim.o.foldlevelstart  = 99
vim.o.cursorline      = true
vim.o.textwidth       = 120
vim.o.cursorcolumn    = true
vim.o.list            = true
vim.o.background      = "dark"
vim.o.splitbelow      = true
vim.o.splitright      = true
vim.o.termguicolors   = true
vim.o.wrap            = false
vim.o.swapfile        = false
vim.o.showmode        = false
vim.o.autoread        = true
vim.o.updatetime      = 300
vim.o.showtabline     = 2
vim.o.laststatus      = 3
vim.g.clipboard = {
    name = 'wl-clipboard',
    copy  = { ['+'] = 'wl-copy',          ['*'] = 'wl-copy --primary' },
    paste = { ['+'] = 'wl-paste --no-newline', ['*'] = 'wl-paste --no-newline --primary' },
    cache_enabled = 0,
}
vim.o.clipboard       = 'unnamedplus'
vim.o.shortmess       = vim.o.shortmess .. 'c'
vim.o.pumheight       = 10
vim.o.sessionoptions  = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.g.syntax          = "enable"
vim.o.completeopt     = "menu,menuone,noselect,noinsert"
vim.g.loaded_perl_provider = 0

vim.cmd("filetype plugin indent on")
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.complete:append({ 'kspell' })
vim.opt.listchars = { tab = '•·' }

local grp = vim.api.nvim_create_augroup('local_config', { clear = true })

local function run_detached(cmd, opts)
    local ok, err = pcall(vim.system, cmd, vim.tbl_extend('force', { detach = true }, opts or {}))
    if not ok then vim.notify(err, vim.log.levels.WARN) end
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI', 'TermClose', 'TermLeave' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' then vim.cmd('checktime') end
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = grp, pattern = '*',
    callback = function()
        vim.cmd([[silent! keepjumps keeppatterns %s/\s\+$//e]])
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = grp, pattern = '*alias',
    callback = function(ev) vim.bo[ev.buf].filetype = 'sh' end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = grp,
    pattern = vim.fn.expand('~/Projects/personal/dotfiles/linux/waybar/.config/waybar/config'),
    callback = function() run_detached({ 'killall', '-SIGUSR2', 'waybar' }) end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = grp,
    pattern = vim.fn.expand('~/Projects/personal/dotfiles/linux/waybar/.config/waybar/style.css'),
    callback = function() run_detached({ 'killall', '-SIGUSR2', 'waybar' }) end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = grp,
    pattern = vim.fn.expand('~/.config/kitty/kitty.conf'),
    callback = function() run_detached({ 'sh', '-c', 'kill -SIGUSR1 $(pgrep kitty)' }) end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = grp,
    pattern = vim.fn.expand('~/.config/bspwm/bspwmrc'),
    callback = function() run_detached({ 'bspc', 'wm', '-r' }) end,
})
