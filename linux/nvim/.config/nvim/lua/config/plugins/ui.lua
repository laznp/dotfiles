-- ─── notifications ───────────────────────────────────────────────────────────
vim.notify = require("notify")
vim.notify.setup({ background_colour = "#000000" })

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
            { 'diagnostics', sources = { 'nvim_lsp' } },
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

-- ─── devicons + buffer tabs ───────────────────────────────────────────────────
require('nvim-web-devicons').setup()

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

require('bufdel').setup { next = 'cycle', quit = true }

-- ─── indent guides ────────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('BufRead', {
    once = true,
    callback = function() require("ibl").setup() end,
})
