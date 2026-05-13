-- ── Clipboard: pbcopy/pbpaste (macOS) ──
vim.g.clipboard = {
    name = 'MacClipboard',
    copy  = { ['+'] = 'pbcopy',      ['*'] = 'pbcopy' },
    paste = { ['+'] = 'pbpaste',     ['*'] = 'pbpaste' },
    cache_enabled = 0,
}
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

-- ── Mac overrides ──
-- window-picker for neo-tree (lazy-loaded)
vim.api.nvim_create_autocmd('User', {
    pattern = 'NeoTreeBufferEnter',
    once = true,
    callback = function()
        require('window-picker').setup {
            hint = 'floating-big-letter',
            selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                bo = {
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    buftype  = { 'terminal', 'quickfix' },
                },
            },
        }
    end,
})
