vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    once = true,
    callback = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require('cmp')
        cmp.setup {
            snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
            mapping = {
                ['<C-d>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),       { 'i', 'c' }),
                ['<C-y>']     = cmp.config.disable,
                ['<C-e>']     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                ['<CR>']      = cmp.mapping.confirm({ select = true }),
                ['<Down>']    = cmp.mapping.select_next_item(),
                ['<Up>']      = cmp.mapping.select_prev_item(),
            },
            window = {
                completion    = { border = "rounded", winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None", col_offset = -3, side_padding = 0 },
                documentation = { border = "rounded", winhighlight = "Normal:CmpDocs,FloatBorder:FloatBorder,CursorLine:CmpDocs,Search:None", col_offset = -3, side_padding = 0 },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({
                        mode = "symbol_text", maxwidth = 50,
                        menu = { buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]" },
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
            },
            sources = cmp.config.sources({ { name = 'luasnip' }, { name = 'buffer' }, { name = 'nvim_lsp' }, { name = 'path' } }),
        }

        cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
        cmp.setup.filetype({ "sql" }, { sources = { { name = "buffer" } } })

        require('nvim-autopairs').setup { check_ts = true, disable_filetype = { "vim" } }
        cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } }))
    end,
})
