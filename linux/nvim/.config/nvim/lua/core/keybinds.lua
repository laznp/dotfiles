local map = vim.keymap.set
vim.g.mapleader = ' '
-- split window
map('n', '<Leader>|', ':vsp<CR>', { noremap = true, silent = true })
map('n', '<Leader>_', ':sp<CR>', { noremap = true, silent = true })

-- toogle file explorer
map('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- yank 1 line
map('n', '<S-y>', 'yy', { noremap = true, silent = true })

-- windows movement
map('n', '<C-h>', ':NvimTmuxNavigateLeft<CR>', { noremap = true, silent = true })
map('n', '<C-j>', ':NvimTmuxNavigateDown<CR>', { noremap = true, silent = true })
map('n', '<C-k>', ':NvimTmuxNavigateUp<CR>', { noremap = true, silent = true })
map('n', '<C-l>', ':NvimTmuxNavigateRight<CR>', { noremap = true, silent = true })
map('n', '<C-q>', ':close<CR>', { noremap = true, silent = true })

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
map('n', '<S-q>', ':BufDel<CR>', { noremap = true, silent = true })
-- map('n', '<S-q>', ':BufferClose<CR>', { noremap = true, silent = true })

-- nerdcommenter
map('n', '<C-_>', '<Plug>NERDCommenterToggle', { silent = true })
map('n', '<C-/>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
map('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { silent = true })
map('v', '<C-/>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })
map('v', '<C-c>', '<Plug>NERDCommenterSexy<CR>gv', { silent = true })

-- fzf
map('n', '<C-p>', ':FzfLua files<CR>', { noremap = true, silent = true })
map('n', '<C-b>', ':FzfLua buffers<CR>', { noremap = true, silent = true })
map('n', '<C-f>', ':FzfLua live_grep<CR>', { noremap = true, silent = true })

-- clear search
map('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

-- jump to beginnig/end of line or jump to beginning/end of buffer paragraph
map('n', '<S-h>', '0', { noremap = true, silent = true})
map('n', '<S-l>', '$', { noremap = true, silent = true})

-- selection to beginning/end of line with shift
map('v', '<S-l>', '$<Left>', { noremap = true, silent = true})
map('v', '<S-h>', '0', { noremap = true, silent = true})

-- autocomplete
map('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<TAB>"', {expr = true})
map('i', '<TAB>', 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {expr = true})

-- surround selected word
map('v', '"', 'qqc""<ESC>Pq', { noremap = true, silent = true })
map('v', "'", "qqc''<ESC>Pq", { noremap = true, silent = true })
map('v', "(", "qqc()<ESC>Pq", { noremap = true, silent = true })
map('v', "{", "qqc{}<ESC>Pq", { noremap = true, silent = true })
map('v', "[", "qqc[]<ESC>Pq", { noremap = true, silent = true })

-- fine cmdline
map('n', '<S-k>', ':m .-2<CR>==', { noremap = true, silent = true})
map('n', '<S-j>', ':m .+1<CR>==', { noremap = true, silent = true})
map('v', '<S-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true})
map('v', '<S-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true})

-- sniprun
map('n', '<Leader>r', ':SnipRun<CR>', { noremap = true, silent = true})
map('v', '<Leader>r', ":'<,'>SnipRun<CR>", { noremap = true, silent = true})

