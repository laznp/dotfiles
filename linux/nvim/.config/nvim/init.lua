-- ─── settings ────────────────────────────────────────────────────────────────
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
vim.o.clipboard = 'unnamedplus'
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

local local_config_group = vim.api.nvim_create_augroup('local_config', { clear = true })

local function run_detached(cmd, opts)
    local ok, err = pcall(vim.system, cmd, vim.tbl_extend('force', { detach = true }, opts or {}))
    if not ok then
        vim.notify(err, vim.log.levels.WARN)
    end
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI', 'TermClose', 'TermLeave' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' then
            vim.cmd('checktime')
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = local_config_group,
    pattern = '*',
    callback = function()
        vim.cmd([[silent! keepjumps keeppatterns %s/\s\+$//e]])
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = local_config_group,
    pattern = '*alias',
    callback = function(ev)
        vim.bo[ev.buf].filetype = 'sh'
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = local_config_group,
    pattern = vim.fn.expand('~/Projects/personal/dotfiles/linux/waybar/.config/waybar/config'),
    callback = function()
        run_detached({ 'killall', '-SIGUSR2', 'waybar' })
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = local_config_group,
    pattern = vim.fn.expand('~/Projects/personal/dotfiles/linux/waybar/.config/waybar/style.css'),
    callback = function()
        run_detached({ 'killall', '-SIGUSR2', 'waybar' })
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = local_config_group,
    pattern = vim.fn.expand('~/.config/kitty/kitty.conf'),
    callback = function()
        run_detached({ 'sh', '-c', 'kill -SIGUSR1 $(pgrep kitty)' })
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = local_config_group,
    pattern = vim.fn.expand('~/.config/bspwm/bspwmrc'),
    callback = function()
        run_detached({ 'bspc', 'wm', '-r' })
    end,
})

-- ─── keybinds ────────────────────────────────────────────────────────────────
local map = vim.keymap.set
vim.g.mapleader = ' '

local neo_tree_loaded = false
local fzf_loaded = false

local function load_neo_tree()
    if neo_tree_loaded then
        return
    end

    require('neo-tree').setup {
        close_if_last_window = false,
        popup_border_style   = "rounded",
        enable_git_status    = true,
        enable_diagnostics   = false,
        sort_case_insensitive = true,
        default_component_configs = {
            indent = { indent_size = 2, padding = 1 },
            git_status = {
                symbols = {
                    added     = "+",  modified  = "~",
                    deleted   = "-",  renamed   = "",
                    untracked = "?", ignored   = "",
                    unstaged  = "?", staged    = "",
                    conflict  = "",
                },
            },
        },
        window = {
            position = "left",
            width    = 40,
            mappings = {
                ["<cr>"]    = "open",
                ["l"]       = "open",
                ["h"]       = "close_node",
                ["v"]       = "open_vsplit",
                ["s"]       = "open_split",
                ["t"]       = "open_tabnew",
                ["C"]       = "close_node",
                ["z"]       = "close_all_nodes",
                ["R"]       = "refresh",
                ["a"]       = "add",
                ["d"]       = "delete",
                ["r"]       = "rename",
                ["y"]       = "copy_to_clipboard",
                ["x"]       = "cut_to_clipboard",
                ["p"]       = "paste_from_clipboard",
                ["q"]       = "close_window",
                ["?"]       = "show_help",
                ["gy"]      = function(state)
                    local path = state.tree:get_node():get_id()
                    vim.fn.setreg('+', path)
                    vim.notify('Copied: ' .. path)
                end,
            },
        },
        filesystem = {
            filtered_items = {
                visible        = false,
                hide_dotfiles  = false,
                hide_gitignored = false,
            },
            follow_current_file    = { enabled = false },
            use_libuv_file_watcher = false,
            hijack_netrw_behavior  = "open_default",
        },
        buffers = {
            follow_current_file = { enabled = true },
        },
    }

    neo_tree_loaded = true
end

local function load_fzf()
    if fzf_loaded then
        return
    end

    local fzf_actions = require("fzf-lua.actions")
    require('fzf-lua').setup {
        hls = {
            normal = 'Normal',
            border = 'Normal',
            cursor = 'Cursor',
            cursorline = 'CursorLine',
        },
        winopts = {
            height = 0.85, width = 0.80, row = 0.35, col = 0.50,
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            fullscreen = false,
            preview = {
                border = 'border', wrap = 'nowrap', hidden = 'nohidden',
                vertical = 'down:45%', horizontal = 'right:60%', layout = 'flex',
                flip_columns = 120, title = true, scrollbar = 'float', scrollchars = { '█', '' },
                delay = 100,
            },
        },
        keymap = {
            builtin = {
                ["<F2>"] = "toggle-fullscreen", ["<F3>"] = "toggle-preview-wrap",
                ["<F4>"] = "toggle-preview",    ["<F5>"] = "toggle-preview-ccw",
                ["<F6>"] = "toggle-preview-cw", ["<S-down>"] = "preview-page-down",
                ["<S-up>"] = "preview-page-up", ["<S-left>"] = "preview-page-reset",
            },
            fzf = {
                ["ctrl-z"] = "abort",      ["ctrl-u"] = "unix-line-discard",
                ["ctrl-f"] = "half-page-down", ["ctrl-b"] = "half-page-up",
                ["ctrl-a"] = "beginning-of-line", ["ctrl-e"] = "end-of-line",
                ["alt-a"]  = "toggle-all",
            },
        },
        fzf_opts = { ['--ansi'] = '', ['--prompt'] = '> ', ['--info'] = 'inline', ['--height'] = '100%', ['--layout'] = 'default' },
        previewers = {
            cat      = { cmd = "cat",  args = "--number" },
            bat      = { cmd = "bat",  args = "--style=numbers,changes --color always", theme = 'OneHalfDark' },
            head     = { cmd = "head" },
            git_diff = { cmd = "git diff", args = "--color" },
            man      = { cmd = "man -c %s | col -bx" },
            builtin  = { syntax = true, syntax_limit_b = 1024 * 1024 },
        },
        files = {
            prompt = '  ', git_icons = true, file_icons = true, color_icons = true,
            actions = {
                ["default"] = fzf_actions.file_edit,   ["ctrl-s"] = fzf_actions.file_split,
                ["ctrl-v"]  = fzf_actions.file_vsplit,  ["ctrl-t"] = fzf_actions.file_tabedit,
                ["alt-q"]   = fzf_actions.file_sel_to_qf,
                ["ctrl-y"]  = function(selected) print(selected[1]) end,
            },
        },
        git = {
            files    = { prompt = ' ', cmd = 'git ls-files --exclude-standard', git_icons = true, file_icons = true, color_icons = true },
            status   = { prompt = ' ', cmd = "git status -s", previewer = "git_diff", file_icons = true, git_icons = true },
            commits  = {
                prompt = '  ', cmd = "git log --pretty=oneline --abbrev-commit --color",
                preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                actions = { ["default"] = fzf_actions.git_checkout },
            },
            bcommits = {
                prompt = '  ', cmd = "git log --pretty=oneline --abbrev-commit --color",
                preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                actions = { ["default"] = fzf_actions.git_buf_edit, ["ctrl-s"] = fzf_actions.git_buf_split,
                            ["ctrl-v"] = fzf_actions.git_buf_vsplit, ["ctrl-t"] = fzf_actions.git_buf_tabedit },
            },
            branches = {
                prompt = ' ', cmd = "git branch --all --color",
                preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
                actions = { ["default"] = fzf_actions.git_switch },
            },
            icons = { ["M"] = { icon = "M", color = "yellow" }, ["D"] = { icon = "D", color = "red" },
                      ["A"] = { icon = "A", color = "green" },  ["?"] = { icon = "?", color = "magenta" } },
        },
        grep = {
            prompt = 'Rg❯ ', input_prompt = 'Grep For❯ ',
            rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,node_modules}/*'",
            git_icons = true, file_icons = true, color_icons = true,
            glob_flag = "--iglob", glob_separator = "%s%-%-",
        },
        args     = { prompt = 'Args❯ ',    files_only = true, actions = { ["ctrl-x"] = fzf_actions.arg_del } },
        oldfiles = { prompt = 'History❯ ', cwd_only = false },
        buffers  = {
            prompt = 'Buffers❯ ', file_icons = true, color_icons = true, sort_lastused = true,
            actions = { ["default"] = fzf_actions.buf_edit, ["ctrl-s"] = fzf_actions.buf_split,
                        ["ctrl-v"]  = fzf_actions.buf_vsplit, ["ctrl-t"] = fzf_actions.buf_tabedit,
                        ["ctrl-x"]  = fzf_actions.buf_del },
        },
        blines = {
            previewer = "builtin", prompt = 'BLines❯ ',
            actions = { ["default"] = fzf_actions.buf_edit, ["ctrl-s"] = fzf_actions.buf_split,
                        ["ctrl-v"]  = fzf_actions.buf_vsplit, ["ctrl-t"] = fzf_actions.buf_tabedit },
        },
        colorschemes = {
            prompt = '  ', live_preview = true,
            actions = { ["default"] = fzf_actions.colorscheme },
            winopts = { height = 0.55, width = 0.30 },
        },
        quickfix = { file_icons = true, git_icons = true },
        lsp = {
            prompt = '❯ ', async_or_timeout = true, file_icons = true, lsp_icons = true, severity = "hint",
            icons = {
                ["Error"]       = { icon = "", color = "red" },
                ["Warning"]     = { icon = "", color = "yellow" },
                ["Information"] = { icon = "", color = "blue" },
                ["Hint"]        = { icon = "", color = "magenta" },
            },
        },
        file_icon_padding = '', file_icon_colors = { ["lua"] = "blue", ["hcl"] = "magenta" },
    }

    fzf_loaded = true
end

-- split window
map('n', '<Leader>|', ':vsp<CR>',  { noremap = true, silent = true })
map('n', '<Leader>_', ':sp<CR>',   { noremap = true, silent = true })

-- file explorer
map('n', '<Leader>e', function()
    load_neo_tree()
    vim.cmd('Neotree toggle')
end, { noremap = true, silent = true })

-- yank line
map('n', '<S-y>', 'yy', { noremap = true, silent = true })

-- window / tmux navigation
map('n', '<C-h>', ':NvimTmuxNavigateLeft<CR>',  { noremap = true, silent = true })
map('n', '<C-j>', ':NvimTmuxNavigateDown<CR>',  { noremap = true, silent = true })
map('n', '<C-k>', ':NvimTmuxNavigateUp<CR>',    { noremap = true, silent = true })
map('n', '<C-l>', ':NvimTmuxNavigateRight<CR>', { noremap = true, silent = true })
map('n', '<C-q>', ':close<CR>',                 { noremap = true, silent = true })

-- indenting
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- cursor movement in insert mode
map('i', '<C-h>', '<Left>',  { noremap = true, silent = true })
map('i', '<C-j>', '<Down>',  { noremap = true, silent = true })
map('i', '<C-k>', '<Up>',    { noremap = true, silent = true })
map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- buffer navigation
map('n', '<S-TAB>', ':bprev<CR>', { noremap = true, silent = true })
map('n', '<TAB>',   ':bnext<CR>', { noremap = true, silent = true })
map('n', '<S-q>',   ':BufDel<CR>', { noremap = true, silent = true })

-- nerdcommenter
map('n', '<C-_>', '<Plug>NERDCommenterToggle',         { silent = true })
map('n', '<C-/>', '<Plug>NERDCommenterToggle',         { noremap = true, silent = true })
map('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv',   { silent = true })
map('v', '<C-/>', '<Plug>NERDCommenterToggle<CR>gv',   { noremap = true, silent = true })
map('v', '<C-c>', '<Plug>NERDCommenterSexy<CR>gv',     { silent = true })

-- fzf
map('n', '<C-p>', function()
    load_fzf()
    require('fzf-lua').files()
end, { noremap = true, silent = true })
map('n', '<C-b>', function()
    load_fzf()
    require('fzf-lua').buffers()
end, { noremap = true, silent = true })
map('n', '<C-f>', function()
    load_fzf()
    require('fzf-lua').live_grep()
end, { noremap = true, silent = true })

-- clear search highlight
map('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

-- line start / end
map('n', '<S-h>', '0', { noremap = true, silent = true })
map('n', '<S-l>', '$', { noremap = true, silent = true })
map('v', '<S-l>', '$<Left>', { noremap = true, silent = true })
map('v', '<S-h>', '0',       { noremap = true, silent = true })

-- pumvisible tab cycling
map('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<TAB>"', { expr = true })
map('i', '<TAB>',   'pumvisible() ? "\\<C-n>" : "\\<TAB>"', { expr = true })

-- surround selected word
map('v', '"', 'qqc""<ESC>Pq',  { noremap = true, silent = true })
map('v', "'", "qqc''<ESC>Pq",  { noremap = true, silent = true })
map('v', '(', 'qqc()<ESC>Pq',  { noremap = true, silent = true })
map('v', '{', 'qqc{}<ESC>Pq',  { noremap = true, silent = true })
map('v', '[', 'qqc[]<ESC>Pq',  { noremap = true, silent = true })

-- move lines
map('n', '<S-k>', ':m .-2<CR>==',       { noremap = true, silent = true })
map('n', '<S-j>', ':m .+1<CR>==',       { noremap = true, silent = true })
map('v', '<S-k>', ":m '<-2<CR>gv=gv",   { noremap = true, silent = true })
map('v', '<S-j>', ":m '>+1<CR>gv=gv",   { noremap = true, silent = true })

-- ─── plugins (vim.pack) ───────────────────────────────────────────────────────
local gh = function(x) return 'https://github.com/' .. x end

-- build hooks must be registered before vim.pack.add()
vim.api.nvim_create_autocmd('PackChanged', {
    group = local_config_group,
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then return end

        if name == 'mason.nvim' then
            vim.cmd('MasonUpdate')
        elseif name == 'nvim-treesitter' then
            vim.cmd('TSUpdate')
        end
    end
})

vim.pack.add({
    gh('nvim-tree/nvim-web-devicons'),

    gh('navarasu/onedark.nvim'),
    gh('nvim-lualine/lualine.nvim'),

    gh('MunifTanjim/nui.nvim'),
    gh('nvim-neo-tree/neo-tree.nvim'),
    gh('akinsho/bufferline.nvim'),
    gh('ojroques/nvim-bufdel'),
    gh('rmagatti/auto-session'),

    gh('vijaymarupudi/nvim-fzf'),
    gh('ibhagwan/fzf-lua'),

    gh('nvim-lua/plenary.nvim'),
    gh('lewis6991/gitsigns.nvim'),

    gh('lukas-reineke/indent-blankline.nvim'),

    -- lsp + completion (native vim.lsp — no nvim-lspconfig needed)
    gh('williamboman/mason.nvim'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('L3MON4D3/LuaSnip'),
    gh('saadparwaiz1/cmp_luasnip'),
    gh('rafamadriz/friendly-snippets'),
    gh('onsails/lspkind.nvim'),
    gh('hrsh7th/nvim-cmp'),

    { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },

    gh('windwp/nvim-autopairs'),
    gh('rcarriga/nvim-notify'),
    gh('preservim/nerdcommenter'),
    { src = gh('jake-stewart/multicursor.nvim'), version = '1.0' },
    gh('alexghergh/nvim-tmux-navigation'),
})

-- nvim-treesitter keeps queries under its runtime/ directory, so add that subdir explicitly.
local treesitter_pack = vim.pack.get({ 'nvim-treesitter' })[1]
if treesitter_pack then
    vim.opt.rtp:append(treesitter_pack.path .. '/runtime')
end

-- ─── colorscheme ─────────────────────────────────────────────────────────────
require('onedark').setup {
    style = 'darker',
    transparent = true,
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,
    toggle_style_key = nil,
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
    code_style = {
        comments = 'italic', keywords = 'italic',
        functions = 'italic', strings = 'none', variables = 'none',
    },
    lualine = { transparent = true },
    colors = {},
    highlights = {
        ["PmenuSel"]    = { bg = "$bg3", fg = "NONE" },
        ["Pmenu"]       = { fg = "$fg",  bg = "$bg0" },
        ["CmpDocs"]     = { fg = "$fg",  bg = "$bg0" },
        ["FloatBorder"] = { fg = "$fg",  bg = "$bg0" },
        ["StatusLine"]  = { bg = "NONE" },
    },
    diagnostics = { darker = true, undercurl = true, background = true },
}
require('onedark').load()

-- ─── statusline ──────────────────────────────────────────────────────────────
local function diff_source()
    local gs = vim.b.gitsigns_status_dict
    if gs then return { added = gs.added, modified = gs.changed, removed = gs.removed } end
end

local map_mode = {
    ['NORMAL']  = ' ', ['VISUAL']  = '󰈈 ', ['V-BLOCK'] = '󰈈 ', ['V-LINE'] = '󰈈 ',
    ['INSERT']  = ' ', ['COMMAND'] = ' ', ['TERM']    = ' ',
    ['r'] = 'REPLACE', ['R'] = 'REPLACE', ['rm'] = 'MORE', ['r?'] = 'CONFIRM', ['!'] = 'SHELL',
}

local colors = {
    yellow = '#ECBE7B', cyan = '#008080', darkblue = '#081633', green = '#98be65',
    orange = '#FF8800', violet = '#a9a1e1', magenta = '#c678dd',
    blue = '#51afef', red = '#ec5f67', bg = "#2c323c", fg = "#abb2bf",
}

local function color_mode()
    vim.opt.fillchars = { stl = "─", stlnc = "─" }
    local mc = {
        n = colors.orange, i = colors.blue, v = colors.magenta, V = colors.magenta,
        c = colors.red, no = colors.red, s = colors.orange, S = colors.orange,
        ic = colors.yellow, R = colors.violet, Rv = colors.violet,
        cv = colors.red, ce = colors.red, r = colors.blue, rm = colors.blue,
        ["r?"] = colors.blue, ["!"] = colors.red, t = colors.red,
        [""] = colors.magenta, [""] = colors.orange,
    }
    return { fg = mc[vim.fn.mode()], bg = "None" }
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators   = { left = '', right = '' },
        disabled_filetypes   = { 'neo-tree' },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(s) return map_mode[s] or s end, color = color_mode } },
        lualine_b = {},
        lualine_c = {
            "%=",
            { "filetype",  color = color_mode, icon_only = true, icon = { align = 'right' } },
            { "filename",  color = color_mode, file_status = true, path = 2, symbols = { modified = '󰧞' } },
        },
        lualine_x = {
            { 'diff', source = diff_source },
            { 'branch', color = color_mode },
            { 'diagnostics', sources = { 'nvim_lsp', 'coc' } },
        },
        lualine_y = { { "progress", color = color_mode } },
        lualine_z = { { 'location', color = color_mode } },
    },
    inactive_sections = {
        lualine_a = {}, lualine_b = {},
        lualine_c = { 'filename' }, lualine_x = { 'location' },
        lualine_y = {}, lualine_z = {},
    },
    extensions = { 'fzf', 'toggleterm' },
}

-- ─── file explorer ────────────────────────────────────────────────────────────
require('nvim-web-devicons').setup()

-- ─── buffer tabs ─────────────────────────────────────────────────────────────
require('bufferline').setup {
    options = {
        style_preset  = "minimal",
        mode          = "buffers",
        numbers       = "none",
        close_command = "BufDel",
        right_mouse_command  = "BufDel",
        left_mouse_command   = "buffer %d",
        middle_mouse_command = nil,
        indicator    = { icon = '▎', style = "icon" },
        buffer_close_icon       = '',
        modified_icon           = '●',
        close_icon              = '',
        left_trunc_marker       = '',
        right_trunc_marker      = '',
        max_name_length         = 20,
        max_prefix_length       = 15,
        truncate_names          = true,
        tab_size                = 20,
        offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "center", separator = true } },
        color_icons             = true,
        show_buffer_icons       = true,
        show_buffer_close_icons = false,
        show_close_icon         = true,
        show_tab_indicators     = true,
        show_duplicate_prefix   = true,
        persist_buffer_sort     = false,
        separator_style         = "thin",
        enforce_regular_tabs    = false,
        always_show_bufferline  = true,
        hover = { enabled = true, delay = 200, reveal = { 'close' } },
    },
}

-- ─── buffer delete ────────────────────────────────────────────────────────────
require('bufdel').setup { next = 'cycle', quit = true }

-- ─── session management ───────────────────────────────────────────────────────
require("auto-session").setup {
    enabled  = true,
    root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_save   = true,
    auto_restore = true,
    auto_create  = true,
    suppressed_dirs       = { '~/', '~/Projects', '~/Downloads', '/' },
    auto_restore_last_session = false,
    use_git_branch        = false,
    lazy_support          = false,
    close_unsupported_windows = true,
    args_allow_single_directory = true,
    continue_restore_on_error   = true,
    log_level = "error",
}

-- ─── git signs ────────────────────────────────────────────────────────────────
require('gitsigns').setup {
    signs = {
        add          = { text = '+' }, change       = { text = '~' },
        delete       = { text = '-' }, topdelete    = { text = '-' },
        changedelete = { text = '~' }, untracked    = { text = '?' },
    },
    signcolumn = true, numhl = false, linehl = false, word_diff = false,
    watch_gitdir        = { interval = 1000, follow_files = true },
    attach_to_untracked = true,
    current_line_blame  = false,
    current_line_blame_opts = { virt_text = true, virt_text_pos = 'eol', delay = 1000 },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6, update_debounce = 100, max_file_length = 40000,
    preview_config = { border = 'single', style = 'minimal', relative = 'cursor', row = 0, col = 1 },
}

-- ─── indent guides ────────────────────────────────────────────────────────────
require("ibl").setup()

-- ─── lsp tool installer ──────────────────────────────────────────────────────
local mason_tools = { "ruff", "rust-analyzer", "bash-language-server", "terraform-ls", "clangd" }
require("mason").setup()
local mr = require("mason-registry")
mr:on("package:install:success", function()
    vim.defer_fn(function()
        vim.api.nvim_exec_autocmds("FileType", { buf = vim.api.nvim_get_current_buf() })
    end, 100)
end)
mr.refresh(function()
    for _, tool in ipairs(mason_tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then p:install() end
    end
end)

-- ─── completion ───────────────────────────────────────────────────────────────
local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
    snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
    mapping = {
        ['<C-d>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),       { 'i', 'c' }),
        ['<C-y>']     = cmp.config.disable,
        ['<C-e>']     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),
        ['<Down>']    = cmp.mapping.select_next_item(),
        ['<Up>']      = cmp.mapping.select_prev_item(),
    },
    window = {
        completion    = { border = "rounded", winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None", col_offset = -3, side_padding = 0 },
        documentation = { border = "rounded", winhighlight = "Normal:CmpDocs,FloatBorder:FloatBorder,CursorLine:CmpDocs,Search:None", col_offset = -3, side_padding = 0 },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
                mode = "symbol_text", maxwidth = 50,
                menu = { buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]" },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },
    sources = cmp.config.sources({ { name = 'luasnip' }, { name = 'buffer' }, { name = 'nvim_lsp' }, { name = 'path' } }),
}

cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})
cmp.setup.filetype({ "sql" }, { sources = { { name = "buffer" } } })

local diag_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(diag_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    float = { border = 'rounded', source = 'if_many' },
    signs = true,
})

-- ─── lsp (native vim.lsp — no nvim-lspconfig) ────────────────────────────────
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_servers = {
    ruff = {
        cmd = { 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    },
    rust_analyzer = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'Cargo.lock' },
    },
    bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'bash', 'sh' },
        root_markers = { '.git' },
    },
    clangd = {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
    },
    terraformls = {
        cmd = { 'terraform-ls', 'serve' },
        filetypes = { 'terraform', 'hcl', 'terraform-vars' },
        root_markers = { '.terraform', '.git' },
    },
}

vim.lsp.config('*', {
    capabilities = capabilities,
})

local lsp_group = vim.api.nvim_create_augroup('native_lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
    end,
})

for name, config in pairs(lsp_servers) do
    vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(lsp_servers))

-- ─── treesitter ───────────────────────────────────────────────────────────────
require('nvim-treesitter').install {
    'python', 'rust', 'hcl', 'lua', 'vim', 'dockerfile',
    'terraform', 'cpp', 'c', 'javascript', 'yaml', 'markdown', 'markdown_inline', 'html',
}

vim.api.nvim_create_autocmd("FileType", {
    pattern  = { 'python', 'rust', 'hcl', 'lua', 'vim', 'dockerfile',
                 'terraform', 'cpp', 'c', 'javascript', 'yaml', 'markdown', 'html' },
    callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern  = "markdown",
    callback = function()
        vim.keymap.set('n', 'gf', function()
            local line = vim.api.nvim_get_current_line()
            local link = line:match('%[.-%]%(([^)]+)%)')
            if not link then
                vim.notify('No markdown link found', vim.log.levels.WARN)
                return
            end
            link = link:gsub('#.*$', '')
            local current_file = vim.fn.expand('%:p')
            local current_dir  = vim.fn.fnamemodify(current_file, ':h')
            local full_path    = vim.fn.simplify(current_dir .. '/' .. link)
            if vim.fn.filereadable(full_path) == 1 then
                vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
            else
                vim.notify('File not found!\nLooking for: ' .. full_path, vim.log.levels.ERROR)
            end
        end, { buffer = true, silent = false, noremap = true })
        vim.keymap.set('n', '<CR>', 'gf', { buffer = true, remap = true })
    end,
})

-- ─── auto pairs ───────────────────────────────────────────────────────────────
require('nvim-autopairs').setup { check_ts = true, disable_filetype = { "vim" } }
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } }))

-- ─── notifications ────────────────────────────────────────────────────────────
vim.notify = require("notify")
vim.notify.setup({ background_colour = "#000000" })

-- ─── comments ─────────────────────────────────────────────────────────────────
vim.g.NERDCommentEmptyLines      = 0
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDSpaceDelims            = 1
vim.g.NERDToggleCheckAllLines    = 1
vim.g.NERDCompactSexyComs        = 1

-- ─── multi-cursor ─────────────────────────────────────────────────────────────
local mc = require("multicursor-nvim")
mc.setup()
vim.keymap.set({ "n", "v" }, "<c-n>", function() mc.addCursor("*") end)
vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<esc>", function()
    if not mc.cursorsEnabled() then mc.enableCursors()
    elseif mc.hasCursors() then mc.clearCursors()
    end
end)

-- ─── tmux navigation ─────────────────────────────────────────────────────────
require('nvim-tmux-navigation').setup { disable_when_zoomed = true }
