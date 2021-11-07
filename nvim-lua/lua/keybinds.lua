local map = vim.api.nvim_set_keymap
vim.g.mapleader = ' '
-- clear highlight
map('n', '<Leader>`', ':noh<CR>', { noremap = true, silent = true })

-- toogle file explorer
map('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- windows movement
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- split window
map('n', '<Leader>v', ':vsp<CR>', { noremap = true, silent = true })
map('n', '<Leader>h', ':sp<CR>', { noremap = true, silent = true })
map('n', '<Leader>q', '<C-w>q', { noremap = true, silent = true })

-- indenting
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- cursor movement
map('i', '<C-h>', '<Left>', { noremap = true, silent = true })
map('i', '<C-j>', '<Down>', { noremap = true, silent = true })
map('i', '<C-k>', '<Up>', { noremap = true, silent = true })
map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- tab buffer movement
map('n', '<S-TAB>', ':bp<CR>', { noremap = true, silent = true })
map('n', '<TAB>', ':bn<CR>', { noremap = true, silent = true })
map('n', '<Leader>w', ':bd<CR>', { noremap = true, silent = true })

-- autocomplete
map('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true })
map('i', '<expr><S-TAB>', 'pumvisible() ? \"\\<C-p>\" : \"\\<TAB>\"', { noremap = true, silent = true })

-- nerdcommenter
map('n', '<C-_>', '<Plug>NERDCommenterToggle', { silent = true })
map('n', '<C-/>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
map('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { silent = true })
map('v', '<C-/>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })

-- fzf
map('n', '<C-f>', ':FzfLua files<CR>', { noremap = true, silent = true })
map('n', '<C-b>', ':FzfLua buffers<CR>', { noremap = true, silent = true })

-- clear search
map('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

-- launch fterm
map('n', '<F3>', ':lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
map('t', '<F3>', 'exit<CR>', { noremap = true, silent = true }) -- send exit command to terminal
