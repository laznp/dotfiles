local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  winopts = {
    height           = 0.85,            -- window height
    width            = 0.80,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.50,            -- window col position (0=left, 1=right)
    border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    fullscreen       = false,           -- start fullscreen?
    hl = {
      normal         = 'Normal',        -- window normal color (fg+bg)
      border         = 'Normal',        -- border color (try 'FloatBorder')
      cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
      cursorline     = 'CursorLine',    -- cursor line
    },
    preview = {
      border         = 'border',        -- border|noborder, applies only to
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:45%',      -- up|down:size
      horizontal     = 'right:60%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = 120,             -- #cols to switch to horizontal on flex
      title          = true,            -- preview border title (file/buf)?
      scrollbar      = 'float',         -- `false` or string:'float|border'
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
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
      -- neovim `:tmap` mappings for the fzf win
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
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
  -- fzf '--color=' options (optional)
  --[[ fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Comment" },
      ["fg+"] = { "fg", "Normal" },
      ["bg+"] = { "bg", "CursorLine" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Exception" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
  }, ]]
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
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
      delay           = 100,          -- delay(ms) displaying the preview
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
    },
  },
  -- provider setup
  files = {
    -- previewer         = "cat",       -- uncomment to override previewer
    prompt            = '  ',
    cmd               = '',             -- "find . -type f -printf '%P\n'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    actions = {
      -- set bind to 'false' to disable
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
      -- custom actions are available too
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  git = {
    files = {
      prompt          = ' ',
      cmd             = 'git ls-files --exclude-standard',
      git_icons       = true,           -- show git icons?
      file_icons      = true,           -- show file icons?
      color_icons     = true,           -- colorize file|git icons
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
    -- cmd               = "rg --vimgrep",
    rg_opts           = "--hidden --column --line-number --no-heading " ..
                        "--color=always --smart-case -g '!{.git,node_modules}/*'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    -- 'true' enables file and git icons in 'live_grep'
    -- degrades performance in large datasets, YMMV
    experimental      = false,
    -- live_grep_glob options
    glob_flag         = "--iglob",  -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-"    -- query separator pattern (lua): ' --'
  },
  args = {
    prompt            = 'Args❯ ',
    files_only        = true,
    actions = {
      -- added on top of regular file actions
      ["ctrl-x"]      = actions.arg_del,
    }
  },
  oldfiles = {
    prompt            = 'History❯ ',
    cwd_only          = false,
  },
  buffers = {
    -- previewer      = false,        -- disable the builtin previewer?
    prompt            = 'Buffers❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
      ["ctrl-x"]      = actions.buf_del,
    }
  },
  blines = {
    previewer         = "builtin",    -- set to 'false' to disable
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
    live_preview      = true,       -- apply the colorscheme on preview?
    actions = {
      ["default"]     = actions.colorscheme,
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    },
    winopts = {
      height          = 0.55,
      width           = 0.30,
    },
    post_reset_cb     = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end,
  },
  quickfix = {
    -- cwd               = vim.loop.cwd(),
    file_icons        = true,
    git_icons         = true,
  },
  lsp = {
    prompt            = '❯ ',
    -- cwd               = vim.loop.cwd(),
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = true,       -- timeout(ms) or false for blocking calls
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
  -- uncomment to disable the previewer
  -- nvim = { marks    = { previewer = { _ctor = false } } },
  -- helptags = { previewer = { _ctor = false } },
  -- manpages = { previewer = { _ctor = false } },
  -- uncomment to set dummy win location (help|man bar)
  -- "topleft"  : up
  -- "botright" : down
  -- helptags = { previewer = { split = "topleft" } },
  -- uncomment to use `man` command as native fzf previewer
  -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  -- padding can help kitty term users with
  -- double-width icon rendering
  file_icon_padding = '',
  file_icon_colors = {
    ["lua"]   = "blue",
  },
}
