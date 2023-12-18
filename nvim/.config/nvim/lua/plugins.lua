local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

local packer = require "packer"
local util = require "packer.util"
local join_paths = util.join_paths
local stdpath = vim.fn.stdpath

local user_config = {
    compile_path = join_paths(stdpath 'config', '.packer_compiled.lua'),
}

packer.init(user_config)

return packer.startup(function()
    use "wbthomason/packer.nvim"
    use "preservim/nerdcommenter"
    use "navarasu/onedark.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "windwp/nvim-autopairs"
    use "kyazdani42/nvim-web-devicons"
    use "nvim-lua/plenary.nvim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"
    use "akinsho/toggleterm.nvim"
    use "onsails/lspkind-nvim"
    use "arkav/lualine-lsp-progress"
    use "hashivim/vim-terraform"
    use "ojroques/nvim-bufdel"
    use "nvim-lualine/lualine.nvim"
    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = "nvim-tree/nvim-web-devicons"
    }
    use "haorenW1025/completion-nvim"
    use "nvim-treesitter/completion-treesitter"
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use { "ibhagwan/fzf-lua",
        requires = {
            "vijaymarupudi/nvim-fzf",
            "nvim-tree/nvim-web-devicons"
        }
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        }
    }
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
    }
    -- use {
        -- "mg979/vim-visual-multi",
        -- branch = "master"
    -- }
end)
