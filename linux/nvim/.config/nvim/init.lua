-- ── Clipboard: wl-clipboard (Linux) ──
vim.g.clipboard = {
    name = 'wl-clipboard',
    copy  = { ['+'] = 'wl-copy',          ['*'] = 'wl-copy --primary' },
    paste = { ['+'] = 'wl-paste --no-newline', ['*'] = 'wl-paste --no-newline --primary' },
    cache_enabled = 0,
}
vim.o.clipboard = 'unnamedplus'

-- ── Hot-reload autocmds (Linux only) ──
local grp = vim.api.nvim_create_augroup('local_config', { clear = true })

local function run_detached(cmd, opts)
    local ok, err = pcall(vim.system, cmd, vim.tbl_extend('force', { detach = true }, opts or {}))
    if not ok then vim.notify(err, vim.log.levels.WARN) end
end

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

-- ── Load shared config ──
require('config.options')
require('config.packages')
require('config.plugins.ui')
require('config.plugins.session')
require('config.plugins.git')
require('config.plugins.completion')
require('config.plugins.lsp')
require('config.plugins.treesitter')
require('config.keymaps')
