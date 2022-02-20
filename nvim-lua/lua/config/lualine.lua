vim.api.nvim_exec([[
	au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]], false)

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


local function set_mode()
	local map_mode = {
	['n']    = ' ',
	['no']   = ' ',
	['nov']  = ' ',
	['noV']  = ' ',
	['no'] = ' ',
	['niI']  = ' ',
	['niR']  = ' ',
	['niV']  = ' ',
	['i']   = ' ',
	['ic']  = ' ',
	['ix']  = ' ',
	['s']   = ' ',
	['S']   = ' ',
	['v']   = ' ',
	['V']   = ' ',
	['']  = ' ',
	['r']   = '﯒ ',
	['r?']  = ' ',
	['c']   = ' ',
	['t']   = ' ',
	['!']   = ' ',
	['R']   = ' ',
	}
	local mode_code = vim.fn.mode()
	return map_mode[mode_code]
end

local function set_filename()
	return vim.fn.expand('%:t')
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
  red = '#ec5f67'
}


local lualine = require 'lualine'

local config = {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { set_mode },
    lualine_b = { 'filename' },
    lualine_c = {'filetype'},
    lualine_x = {
        {'diff', source=diff_source }, 'branch',
        {'diagnostics', sources={'nvim_lsp', 'coc'}}
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { require'tabline'.tabline_buffers },
    lualine_x = { require'tabline'.tabline_tabs },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'fzf'}
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
	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
}

lualine.setup(config)
