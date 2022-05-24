local map = vim.api.nvim_set_keymap
vim.g.mapleader = ' '
-- toogle file explorer
map('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- yank 1 line
map('n', '<S-y>', 'yy', { noremap = true, silent = true })

-- windows movement
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map('n', '<C-q>', '<C-w>q', { noremap = true, silent = true })

-- split window
map('n', '<Leader>v', ':vsp<CR>', { noremap = true, silent = true })
map('n', '<Leader>h', ':sp<CR>', { noremap = true, silent = true })

-- indenting
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- cursor movement
map('i', '<C-h>', '<Left>', { noremap = true, silent = true })
map('i', '<C-j>', '<Down>', { noremap = true, silent = true })
map('i', '<C-k>', '<Up>', { noremap = true, silent = true })
map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- tab buffer movement
map('n', '<S-TAB>', ':bprev<CR>', { noremap = true, silent = true })
map('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<S-q>', ':bdelete<CR>', { noremap = true, silent = true })

-- nerdcommenter
map('n', '<C-_>', '<Plug>NERDCommenterToggle', { silent = true })
map('n', '<C-/>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
map('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { silent = true })
map('v', '<C-/>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })

-- fzf
map('n', '<C-f>', ':FzfLua files<CR>', { noremap = true, silent = true })
map('n', '<C-b>', ':FzfLua buffers<CR>', { noremap = true, silent = true })
map('n', '<C-g>', ':FzfLua grep<CR>', { noremap = true, silent = true })

-- clear search
map('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

-- jump to beginnig/end of line or jump to beginning/end of buffer paragraph
map('n', '<S-h>', '0', { noremap = true, silent = true})
map('n', '<S-l>', '$', { noremap = true, silent = true})
map('n', '<S-j>', 'L', { noremap = true, silent = true})
map('n', '<S-K>', 'H', { noremap = true, silent = true})

-- selection to beginning/end of line with shift
map('v', '<S-l>', '$<Left>', { noremap = true, silent = true})
map('v', '<S-h>', '0', { noremap = true, silent = true})

-- autocomplete
map('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<TAB>"', {expr = true})
map('i', '<TAB>', 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {expr = true})
