local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use "preservim/nerdcommenter"
  use "navarasu/onedark.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-autopairs"
  use "kyazdani42/nvim-web-devicons"
  use "akinsho/toggleterm.nvim"
  use "nvim-lua/plenary.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "onsails/lspkind-nvim"
  use "arkav/lualine-lsp-progress"
  use "hashivim/vim-terraform"
  use { 'tami5/lspsaga.nvim', branch = 'nvim51' }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use { "ibhagwan/fzf-lua",
    requires = {
      "vijaymarupudi/nvim-fzf",
      "kyazdani42/nvim-web-devicons"
    }
  }
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    }
  }
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    "kdheepak/tabline.nvim",
    requires = {"hoob3rt/lualine.nvim", "kyazdani42/nvim-web-devicons"}
  }
end)
