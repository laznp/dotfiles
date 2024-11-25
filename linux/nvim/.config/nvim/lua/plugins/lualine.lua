return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local function diff_source()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed
            }
          end
        end

        local map_mode = {
            ['NORMAL']    = ' ',
            ['VISUAL']    = '󰈈 ',
            ['V-BLOCK']    = '󰈈 ',
            ['V-LINE']  = '󰈈 ',
            ['s']    = 'SELECT',
            -- ['CTRL-S']   = 'S-BLOCK',
            ['INSERT']    = ' ',
            ['r']    = 'REPLACE',
            ['R']    = 'REPLACE',
            ['COMMAND']    = ' ',
            ['rm']   = 'MORE',
            ['r?']   = 'CONFIRM',
            ['!']    = 'SHELL',
            ['TERM']    = ' ',
        }

        local function set_filename()
            return vim.fn.expand('%:p') .. " %m"
        end

        local colors = {
          yellow = '#ECBE7B',
          cyan = '#008080',
          darkblue = '#081633',
          green = '#98be65',
          orange = '#FF8800',
          violet = '#a9a1e1',
          magenta = '#c678dd',
          blue = '#51afef',
          red = '#ec5f67',
          bg = "#2c323c",
          fg = "#abb2bf"
        }

        local lualine = require 'lualine'

        local function color_mode()

            vim.opt.fillchars = {
                stl = "─",
                stlnc = "─",
            }

            local mode_color = {
                n = colors.orange,
                i = colors.blue,
                v = colors.magenta,
                [""] = colors.magenta,
                V = colors.magenta,
                c = colors.red,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.purple,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.blue,
                rm = colors.blue,
                ["r?"] = colors.blue,
                ["!"] = colors.red,
                t = colors.red,

            }

            -- return { fg = mode_color[vim.fn.mode()], bg = colors.bg, }
            return { fg = mode_color[vim.fn.mode()], bg = "None", }
        end

        local config = {
          options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {'NvimTree'},
            always_divide_middle = true,
            globalstatus = true,
          },
          sections = {
            lualine_a = { 
                {
                    'mode', 
                    fmt = function(s) return map_mode[s] or s end,
                    color = color_mode 
                } 
            },
            lualine_b = {},
            lualine_c = { 
                "%=",
                {
                    "filetype",
                    color = color_mode,
                    icon_only = true,
                    icon = { align = 'right' },
                },
                {
                    "filename",
                    color = color_mode,
                    file_status = true,
                    path = 2,
                    symbols = {
                        modified = '󰧞',      -- Text to show when the file is modified.
                    }
                },
            },
            lualine_x = {
                {'diff', source=diff_source }, 
                {'branch', color = color_mode},
                {'diagnostics', sources={'nvim_lsp', 'coc'}}
            },
            lualine_y = { 
                {
                    "progress",
                    color = color_mode 
                }
            },
            lualine_z = {
                {
                    'location',
                    color = color_mode
                }
            }
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          extensions = {'fzf','nvim-tree','toggleterm'}
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
          table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right(component)
          table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            'lsp_progress',
            -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
            -- With spinner
            display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
            colors = {
              percentage  = colors.cyan,
              title  = colors.cyan,
              message  = colors.cyan,
              spinner = colors.cyan,
              lsp_client_name = colors.magenta,
              use = true,
            },
            separators = {
            component = ' ',
            progress = ' | ',
            message = { pre = '(', post = ')'},
            percentage = { pre = '', post = '%% ' },
            title = { pre = '', post = ': ' },
            lsp_client_name = { pre = '[', post = ']' },
            spinner = { pre = '', post = '' },
            message = { commenced = 'In Progress', completed = 'Completed' },
            },
            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
            spinner_symbols = { ' ', ' ', ' ', ' ', ' ', ' ' },
        }

        lualine.setup(config)
    end
}
