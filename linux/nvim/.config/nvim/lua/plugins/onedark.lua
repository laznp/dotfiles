return {
    "navarasu/onedark.nvim",
    config = function()
        require('onedark').setup {
            style = 'darker',
            transparent = true,
            term_colors = true,
            ending_tildes = false,
            cmp_itemkind_reverse = false,

            toggle_style_key = nil,
            toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},

            code_style = {
                comments = 'italic',
                keywords = 'italic',
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
    end
}


-- return {
  -- "olimorris/onedarkpro.nvim",
  -- config = function()
      -- require("onedarkpro").setup({
          -- options = {
            -- cursorline = false, -- Use cursorline highlighting?
            -- transparency = true, -- Use a transparent background?
            -- terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
            -- lualine_transparency = true, -- Center bar transparency?
            -- highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
          -- }
        -- })
  -- end
-- }
