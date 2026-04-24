local gh = function(x) return 'https://github.com/' .. x end

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('pack_hooks', { clear = true }),
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then return end
        if name == 'mason.nvim' then
            vim.cmd('MasonUpdate')
        elseif name == 'nvim-treesitter' then
            vim.cmd('TSUpdate')
        end
    end,
})

vim.pack.add({
    gh('nvim-tree/nvim-web-devicons'),
    gh('navarasu/onedark.nvim'),
    gh('nvim-lualine/lualine.nvim'),
    gh('MunifTanjim/nui.nvim'),
    gh('nvim-neo-tree/neo-tree.nvim'),
    gh('akinsho/bufferline.nvim'),
    gh('ojroques/nvim-bufdel'),
    gh('rmagatti/auto-session'),
    gh('vijaymarupudi/nvim-fzf'),
    gh('ibhagwan/fzf-lua'),
    gh('nvim-lua/plenary.nvim'),
    gh('lewis6991/gitsigns.nvim'),
    gh('lukas-reineke/indent-blankline.nvim'),
    gh('williamboman/mason.nvim'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('L3MON4D3/LuaSnip'),
    gh('saadparwaiz1/cmp_luasnip'),
    gh('rafamadriz/friendly-snippets'),
    gh('onsails/lspkind.nvim'),
    gh('hrsh7th/nvim-cmp'),
    { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
    gh('windwp/nvim-autopairs'),
    gh('rcarriga/nvim-notify'),
    gh('preservim/nerdcommenter'),
    { src = gh('jake-stewart/multicursor.nvim'), version = '1.0' },
    gh('alexghergh/nvim-tmux-navigation'),
})

local treesitter_pack = vim.pack.get({ 'nvim-treesitter' })[1]
if treesitter_pack then
    vim.opt.rtp:append(treesitter_pack.path .. '/runtime')
end
