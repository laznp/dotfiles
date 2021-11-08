local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
	use "wbthomason/packer.nvim"
	use "preservim/nerdcommenter"
	use "navarasu/onedark.nvim"
	use "numtostr/FTerm.nvim"
	use "norcalli/nvim-colorizer.lua"
	use "nvim-lualine/lualine.nvim"
	use "crispgm/nvim-tabline"
	use "windwp/nvim-autopairs"
	use "neovim/nvim-lspconfig"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-vsnip"
	use "hrsh7th/vim-vsnip"
	use "nvim-lua/plenary.nvim"
	use "akinsho/toggleterm.nvim"
	use {
		"lewis6991/gitsigns.nvim",
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
	}
	use {
		'ibhagwan/fzf-lua',
		requires = {
			'vijaymarupudi/nvim-fzf',
			'kyazdani42/nvim-web-devicons'
		}
	}

end)
