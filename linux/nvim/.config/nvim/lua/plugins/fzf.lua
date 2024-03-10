return {
    { "ibhagwan/fzf-lua",
        dependencies = {
            "vijaymarupudi/nvim-fzf",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            local actions = require "fzf-lua.actions"
            require'fzf-lua'.setup {
              winopts = {
                height           = 0.85,
                width            = 0.80,
                row              = 0.35,
                col              = 0.50,
                border           = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                fullscreen       = false,
                hl = {
                  normal         = 'Normal',
                  border         = 'Normal',
                  cursor         = 'Cursor',
                  cursorline     = 'CursorLine',
                },
                preview = {
                  border         = 'border',
                  wrap           = 'nowrap',
                  hidden         = 'nohidden',
                  vertical       = 'down:45%',
                  horizontal     = 'right:60%',
                  layout         = 'flex',
                  flip_columns   = 120,
                  title          = true,
                  scrollbar      = 'float',
                  scrollchars    = {'█', '' },
                },
                on_create = function()
                  -- called once upon creation of the fzf main window
                  -- can be used to add custom fzf-lua mappings, e.g:
                  --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
                  --     { silent = true, noremap = true })
                end,
              },
              keymap = {
                builtin = {
                  ["<F2>"]        = "toggle-fullscreen",
                  ["<F3>"]        = "toggle-preview-wrap",
                  ["<F4>"]        = "toggle-preview",
                  ["<F5>"]        = "toggle-preview-ccw",
                  ["<F6>"]        = "toggle-preview-cw",
                  ["<S-down>"]    = "preview-page-down",
                  ["<S-up>"]      = "preview-page-up",
                  ["<S-left>"]    = "preview-page-reset",
                },
                fzf = {
                  ["ctrl-z"]      = "abort",
                  ["ctrl-u"]      = "unix-line-discard",
                  ["ctrl-f"]      = "half-page-down",
                  ["ctrl-b"]      = "half-page-up",
                  ["ctrl-a"]      = "beginning-of-line",
                  ["ctrl-e"]      = "end-of-line",
                  ["alt-a"]       = "toggle-all",
                },
              },
              fzf_opts = {
                ['--ansi']        = '',
                ['--prompt']      = '> ',
                ['--info']        = 'inline',
                ['--height']      = '100%',
                ['--layout']      = 'default',
              },
              previewers = {
                cat = {
                  cmd             = "cat",
                  args            = "--number",
                },
                bat = {
                  cmd             = "bat",
                  args            = "--style=numbers,changes --color always",
                  theme           = 'OneHalfDark',
                  config          = nil,
                },
                head = {
                  cmd             = "head",
                  args            = nil,
                },
                git_diff = {
                  cmd             = "git diff",
                  args            = "--color",
                },
                man = {
                  cmd             = "man -c %s | col -bx",
                },
                builtin = {
                  delay           = 100,
                  syntax          = true,
                  syntax_limit_l  = 0,
                  syntax_limit_b  = 1024*1024,
                },
              },
              files = {
                prompt            = '  ',
                cmd               = '',
                git_icons         = true,
                file_icons        = true,
                color_icons       = true,
                actions = {
                  ["default"]     = actions.file_edit,
                  ["ctrl-s"]      = actions.file_split,
                  ["ctrl-v"]      = actions.file_vsplit,
                  ["ctrl-t"]      = actions.file_tabedit,
                  ["alt-q"]       = actions.file_sel_to_qf,
                  ["ctrl-y"]      = function(selected) print(selected[1]) end,
                }
              },
              git = {
                files = {
                  prompt          = ' ',
                  cmd             = 'git ls-files --exclude-standard',
                  git_icons       = true,
                  file_icons      = true,
                  color_icons     = true,
                },
                status = {
                  prompt        = ' ',
                  cmd           = "git status -s",
                  previewer     = "git_diff",
                  file_icons    = true,
                  git_icons     = true,
                  color_icons   = true,
                },
                commits = {
                  prompt          = '  ',
                  cmd             = "git log --pretty=oneline --abbrev-commit --color",
                  preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                  actions = {
                    ["default"] = actions.git_checkout,
                  },
                },
                bcommits = {
                  prompt          = '  ',
                  cmd             = "git log --pretty=oneline --abbrev-commit --color",
                  preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                  actions = {
                    ["default"] = actions.git_buf_edit,
                    ["ctrl-s"]  = actions.git_buf_split,
                    ["ctrl-v"]  = actions.git_buf_vsplit,
                    ["ctrl-t"]  = actions.git_buf_tabedit,
                  },
                },
                branches = {
                  prompt          = ' ',
                  cmd             = "git branch --all --color",
                  preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
                  actions = {
                    ["default"] = actions.git_switch,
                  },
                },
                icons = {
                  ["M"]           = { icon = "M", color = "yellow" },
                  ["D"]           = { icon = "D", color = "red" },
                  ["A"]           = { icon = "A", color = "green" },
                  ["?"]           = { icon = "?", color = "magenta" },
                },
              },
              grep = {
                prompt            = 'Rg❯ ',
                input_prompt      = 'Grep For❯ ',
                rg_opts           = "--hidden --column --line-number --no-heading " ..
                                    "--color=always --smart-case -g '!{.git,node_modules}/*'",
                git_icons         = true,
                file_icons        = true,
                color_icons       = true,
                experimental      = false,
                glob_flag         = "--iglob",
                glob_separator    = "%s%-%-"
              },
              args = {
                prompt            = 'Args❯ ',
                files_only        = true,
                actions = {
                  ["ctrl-x"]      = actions.arg_del,
                }
              },
              oldfiles = {
                prompt            = 'History❯ ',
                cwd_only          = false,
              },
              buffers = {
                prompt            = 'Buffers❯ ',
                file_icons        = true,
                color_icons       = true,
                sort_lastused     = true,
                actions = {
                  ["default"]     = actions.buf_edit,
                  ["ctrl-s"]      = actions.buf_split,
                  ["ctrl-v"]      = actions.buf_vsplit,
                  ["ctrl-t"]      = actions.buf_tabedit,
                  ["ctrl-x"]      = actions.buf_del,
                }
              },
              blines = {
                previewer         = "builtin",
                prompt            = 'BLines❯ ',
                actions = {
                  ["default"]     = actions.buf_edit,
                  ["ctrl-s"]      = actions.buf_split,
                  ["ctrl-v"]      = actions.buf_vsplit,
                  ["ctrl-t"]      = actions.buf_tabedit,
                }
              },
              colorschemes = {
                prompt            = '  ',
                live_preview      = true,
                actions = {
                  ["default"]     = actions.colorscheme,
                  ["ctrl-y"]      = function(selected) print(selected[1]) end,
                },
                winopts = {
                  height          = 0.55,
                  width           = 0.30,
                },
                post_reset_cb     = function()
                end,
              },
              quickfix = {
                file_icons        = true,
                git_icons         = true,
              },
              lsp = {
                prompt            = '❯ ',
                cwd_only          = false,
                async_or_timeout  = true,
                file_icons        = true,
                git_icons         = false,
                lsp_icons         = true,
                severity          = "hint",
                icons = {
                  ["Error"]       = { icon = "", color = "red" },       -- error
                  ["Warning"]     = { icon = "", color = "yellow" },    -- warning
                  ["Information"] = { icon = "", color = "blue" },      -- info
                  ["Hint"]        = { icon = "", color = "magenta" },   -- hint
                },
              },
              file_icon_padding = '',
              file_icon_colors = {
                ["lua"]   = "blue",
                ["hcl"]   = "magenta",
              },
            }
        end
    }
}
