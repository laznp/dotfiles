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
	['n']    = '',
	['no']   = '',
	['nov']  = '',
	['noV']  = '',
	['no'] = '',
	['niI']  = '',
	['niR']  = '',
	['niV']  = '',
	['i']   = '',
	['ic']  = '',
	['ix']  = '',
	['s']   = '',
	['S']   = '',
	['v']   = '',
	['V']   = '',
	['']  = '',
	['r']   = '﯒',
	['r?']  = '',
	['c']   = '',
	['t']   = '',
	['!']   = '',
	['R']   = '',
	}
	local mode_code = vim.fn.mode()
	return map_mode[mode_code]
end

local function set_filename()
	return vim.fn.expand('%:f')
end


require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { set_mode },
    lualine_b = {{'diff', source=diff_source}, 'branch',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {set_filename},
    lualine_x = {'filetype'},
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
