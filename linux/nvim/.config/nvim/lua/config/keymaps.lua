local map = vim.keymap.set
vim.g.mapleader = ' '

-- ─── lazy plugin loaders ──────────────────────────────────────────────────────
local neo_tree_loaded, fzf_loaded, mc_loaded, tmuxnav_loaded = false, false, false, false

local function load_neo_tree()
    if neo_tree_loaded then return end
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
                    deleted   = "-",  renamed   = "",
                    untracked = "?", ignored   = "",
                    unstaged  = "?", staged    = "",
                    conflict  = "",
                },
            },
        },
        window = {
            position = "left",
            width    = 40,
            mappings = {
                ["<cr>"] = "open",       ["l"]  = "open",
                ["h"]    = "close_node", ["v"]  = "open_vsplit",
                ["s"]    = "open_split", ["t"]  = "open_tabnew",
                ["C"]    = "close_node", ["z"]  = "close_all_nodes",
                ["R"]    = "refresh",    ["a"]  = "add",
                ["d"]    = "delete",     ["r"]  = "rename",
                ["y"]    = "copy_to_clipboard", ["x"] = "cut_to_clipboard",
                ["p"]    = "paste_from_clipboard",
                ["q"]    = "close_window",       ["?"] = "show_help",
                ["gy"]   = function(state)
                    local path = state.tree:get_node():get_id()
                    vim.fn.setreg('+', path)
                    vim.notify('Copied: ' .. path)
                end,
            },
        },
        filesystem = {
            filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = false },
            follow_current_file    = { enabled = false },
            use_libuv_file_watcher = false,
            hijack_netrw_behavior  = "open_default",
        },
        buffers = { follow_current_file = { enabled = true } },
    }
    neo_tree_loaded = true
end

local function load_fzf()
    if fzf_loaded then return end
    local act = require("fzf-lua.actions")
    require('fzf-lua').setup {
        hls = { normal = 'Normal', border = 'Normal', cursor = 'Cursor', cursorline = 'CursorLine' },
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
                ["ctrl-z"] = "abort",          ["ctrl-u"] = "unix-line-discard",
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
                ["default"] = act.file_edit,   ["ctrl-s"] = act.file_split,
                ["ctrl-v"]  = act.file_vsplit,  ["ctrl-t"] = act.file_tabedit,
                ["alt-q"]   = act.file_sel_to_qf,
                ["ctrl-y"]  = function(selected) print(selected[1]) end,
            },
        },
        git = {
            files    = { prompt = ' ', cmd = 'git ls-files --exclude-standard', git_icons = true, file_icons = true, color_icons = true },
            status   = { prompt = ' ', cmd = "git status -s", previewer = "git_diff", file_icons = true, git_icons = true },
            commits  = {
                prompt = '  ', cmd = "git log --pretty=oneline --abbrev-commit --color",
                preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                actions = { ["default"] = act.git_checkout },
            },
            bcommits = {
                prompt = '  ', cmd = "git log --pretty=oneline --abbrev-commit --color",
                preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                actions = { ["default"] = act.git_buf_edit, ["ctrl-s"] = act.git_buf_split,
                            ["ctrl-v"]  = act.git_buf_vsplit, ["ctrl-t"] = act.git_buf_tabedit },
            },
            branches = {
                prompt = ' ', cmd = "git branch --all --color",
                preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
                actions = { ["default"] = act.git_switch },
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
        args     = { prompt = 'Args❯ ',    files_only = true, actions = { ["ctrl-x"] = act.arg_del } },
        oldfiles = { prompt = 'History❯ ', cwd_only = false },
        buffers  = {
            prompt = 'Buffers❯ ', file_icons = true, color_icons = true, sort_lastused = true,
            actions = { ["default"] = act.buf_edit, ["ctrl-s"] = act.buf_split,
                        ["ctrl-v"]  = act.buf_vsplit, ["ctrl-t"] = act.buf_tabedit,
                        ["ctrl-x"]  = act.buf_del },
        },
        blines = {
            previewer = "builtin", prompt = 'BLines❯ ',
            actions = { ["default"] = act.buf_edit, ["ctrl-s"] = act.buf_split,
                        ["ctrl-v"]  = act.buf_vsplit, ["ctrl-t"] = act.buf_tabedit },
        },
        colorschemes = {
            prompt = '  ', live_preview = true,
            actions = { ["default"] = act.colorscheme },
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

local function load_multicursor()
    if mc_loaded then return end
    local mc = require("multicursor-nvim")
    mc.setup()
    mc_loaded = true
end

local function load_tmuxnav()
    if tmuxnav_loaded then return end
    require('nvim-tmux-navigation').setup { disable_when_zoomed = true }
    tmuxnav_loaded = true
end

-- ─── floating terminal ────────────────────────────────────────────────────────
local float_term = { buf = -1, win = -1 }
local function toggle_float_term()
    if vim.api.nvim_win_is_valid(float_term.win) then
        vim.api.nvim_win_hide(float_term.win)
        return
    end
    local width  = math.floor(vim.o.columns * 0.55)
    local height = math.floor(vim.o.lines   * 0.50)
    local col    = math.floor((vim.o.columns - width)  / 2)
    local row    = math.floor((vim.o.lines   - height) / 2)
    if not vim.api.nvim_buf_is_valid(float_term.buf) then
        float_term.buf = vim.api.nvim_create_buf(false, true)
    end
    float_term.win = vim.api.nvim_open_win(float_term.buf, true, {
        relative = 'editor', style = 'minimal', border = 'rounded',
        width = width, height = height, col = col, row = row,
    })
    vim.wo[float_term.win].winhighlight = 'Normal:Normal,FloatBorder:Normal'
    if vim.bo[float_term.buf].buftype ~= 'terminal' then
        vim.cmd('terminal')
        float_term.buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd('startinsert')
end

-- ─── keymaps ─────────────────────────────────────────────────────────────────
map('n', '<Leader>|', ':vsp<CR>',  { noremap = true, silent = true })
map('n', '<Leader>_', ':sp<CR>',   { noremap = true, silent = true })

map('n', '<Leader>e', function() load_neo_tree(); vim.cmd('Neotree toggle') end, { noremap = true, silent = true })

map('n', '<S-y>', 'yy', { noremap = true, silent = true })

map('n', '<C-h>', function() load_tmuxnav(); vim.cmd('NvimTmuxNavigateLeft')  end, { noremap = true, silent = true })
map('n', '<C-j>', function() load_tmuxnav(); vim.cmd('NvimTmuxNavigateDown')  end, { noremap = true, silent = true })
map('n', '<C-k>', function() load_tmuxnav(); vim.cmd('NvimTmuxNavigateUp')    end, { noremap = true, silent = true })
map('n', '<C-l>', function() load_tmuxnav(); vim.cmd('NvimTmuxNavigateRight') end, { noremap = true, silent = true })
map('n', '<C-q>', ':close<CR>', { noremap = true, silent = true })

map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

map('i', '<C-h>', '<Left>',  { noremap = true, silent = true })
map('i', '<C-j>', '<Down>',  { noremap = true, silent = true })
map('i', '<C-k>', '<Up>',    { noremap = true, silent = true })
map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

map('n', '<S-TAB>', ':bprev<CR>',  { noremap = true, silent = true })
map('n', '<TAB>',   ':bnext<CR>',  { noremap = true, silent = true })
map('n', '<S-q>',   ':BufDel<CR>', { noremap = true, silent = true })

map('n', '<C-_>', '<Plug>NERDCommenterToggle',       { silent = true })
map('n', '<C-/>', '<Plug>NERDCommenterToggle',       { noremap = true, silent = true })
map('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { silent = true })
map('v', '<C-/>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })
map('v', '<C-c>', '<Plug>NERDCommenterSexy<CR>gv',   { silent = true })

map('n', '<C-p>', function() load_fzf(); require('fzf-lua').files()     end, { noremap = true, silent = true })
map('n', '<C-b>', function() load_fzf(); require('fzf-lua').buffers()   end, { noremap = true, silent = true })
map('n', '<C-f>', function() load_fzf(); require('fzf-lua').live_grep() end, { noremap = true, silent = true })

map('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

map('n', '<S-h>', '0',       { noremap = true, silent = true })
map('n', '<S-l>', '$',       { noremap = true, silent = true })
map('v', '<S-l>', '$<Left>', { noremap = true, silent = true })
map('v', '<S-h>', '0',       { noremap = true, silent = true })

map('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<TAB>"', { expr = true })
map('i', '<TAB>',   'pumvisible() ? "\\<C-n>" : "\\<TAB>"', { expr = true })

map('v', '"', 'qqc""<ESC>Pq', { noremap = true, silent = true })
map('v', "'", "qqc''<ESC>Pq", { noremap = true, silent = true })
map('v', '(', 'qqc()<ESC>Pq', { noremap = true, silent = true })
map('v', '{', 'qqc{}<ESC>Pq', { noremap = true, silent = true })
map('v', '[', 'qqc[]<ESC>Pq', { noremap = true, silent = true })

map('n', '<S-k>', ':m .-2<CR>==',     { noremap = true, silent = true })
map('n', '<S-j>', ':m .+1<CR>==',     { noremap = true, silent = true })
map('v', '<S-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map('v', '<S-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

map('n', '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true, silent = true })

map('n', '<C-t>', toggle_float_term, { noremap = true, silent = true })
map('t', '<C-t>', function() vim.api.nvim_win_hide(float_term.win) end, { noremap = true, silent = true })

-- ─── comments (global vars) ───────────────────────────────────────────────────
vim.g.NERDCommentEmptyLines      = 0
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDSpaceDelims            = 1
vim.g.NERDToggleCheckAllLines    = 1
vim.g.NERDCompactSexyComs        = 1

-- ─── multi-cursor ─────────────────────────────────────────────────────────────
map({ "n", "v" }, "<c-n>", function()
    load_multicursor(); require("multicursor-nvim").addCursor("*")
end)
map("n", "<c-leftmouse>", function()
    load_multicursor(); require("multicursor-nvim").handleMouse()
end)
map("n", "<esc>", function()
    load_multicursor()
    local mc = require("multicursor-nvim")
    if not mc.cursorsEnabled() then mc.enableCursors()
    elseif mc.hasCursors() then mc.clearCursors()
    end
end)
