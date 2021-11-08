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
    use "airblade/vim-gitgutter"
    use "tpope/vim-fugitive"
	use 'nvim-lualine/lualine.nvim'
	use "crispgm/nvim-tabline"
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
