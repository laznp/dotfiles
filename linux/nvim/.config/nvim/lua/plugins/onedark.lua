return {
    "navarasu/onedark.nvim",
    config = function()
        require('onedark').setup {
            style = 'darker',
            -- style = 'deep',
            transparent = true,
            term_colors = true,
            ending_tildes = false,
            cmp_itemkind_reverse = false,

            toggle_style_key = nil,
            toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},

            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'italic',
                strings = 'none',
                variables = 'none'
            },

            lualine = {
                transparent = true,
            },

            colors = {},
            highlights = {
                ["PmenuSel"] = { bg = "$bg3", fg = "NONE" },
                ["Pmenu"] = { fg = "$fg", bg = "$bg0" },
                ["CmpDocs"] = { fg = "$fg", bg = "$bg0" },
                ["FloatBorder"] = { fg = "$fg", bg = "$bg0" },
            },

            diagnostics = {
                darker = true,
                undercurl = true,
                background = true,
            },
        }
        require('onedark').load()
        -- vim.cmd([[ colorscheme onedark]])
    end
}
