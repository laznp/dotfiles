return {
    "akinsho/bufferline.nvim",
    -- version = "*",
    branch = "main",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        -- local mocha = require("catppuccin.palettes").get_palette "mocha"

        require('bufferline').setup {
            -- highlights = require("catppuccin.groups.integrations.bufferline").get {
                -- styles = { "italic", "bold" },
                -- custom = {
                    -- all = {
                        -- fill = { bg = mocha.base },
                    -- },
                    -- mocha = {
                        -- background = { fg = mocha.text },
                    -- },
                -- },
            -- },
            options = {
            mode = "buffers",
            numbers = "none",
            close_command = "BufDel",
            right_mouse_command = "BufDel",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = {
                icon = '▎',
                style = "icon",
            },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 20,
            max_prefix_length = 15,
            truncate_names = true,
            tab_size = 20,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = function() return "  " .. vim.fn.getcwd() end,
                    text_align = "left",
                    separator = true,
                }
            },
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = false,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true,
            persist_buffer_sort = false,
            separator_style = "thin",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            }
        }
    end
}
