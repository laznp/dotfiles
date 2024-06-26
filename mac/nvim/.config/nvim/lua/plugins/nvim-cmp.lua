return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "onsails/lspkind-nvim",
        "neovim/nvim-lspconfig"
    },
    config = function()
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local feedkey = function(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        end

        -- Setup nvim-cmp.
        local cmp = require'cmp'
        local lspkind = require('lspkind')

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = {
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                            cmp.select_next_item()
                    elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    elseif has_words_before() then
                            cmp.complete()
                    else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function()
                    if cmp.visible() then
                            cmp.select_prev_item()
                    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                    end
                end, { "i", "s" }),
            },
            formatting = {
                format = lspkind.cmp_format({with_text = false, maxwidth = 50})
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- require'lspconfig'.ansiblels.setup{}
        -- require'lspconfig'.dockerls.setup{}
        -- require'lspconfig'.bashls.setup{}
        -- require'lspconfig'.jsonls.setup { capabilities = capabilities }
        require'lspconfig'.pyright.setup{ capabilities = capabilities }
        require'lspconfig'.rust_analyzer.setup{ capabilities = capabilities }
        require'lspconfig'.terraformls.setup{ cmd = {'terraform-ls', 'serve'}, capabilities = capabilities }
        -- require'lspconfig'.yamlls.setup{ capabilities = capabilities }
    end
}
