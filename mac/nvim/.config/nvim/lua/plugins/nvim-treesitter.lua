return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter').install {
            'python',
            'rust',
            'hcl',
            'lua',
            'vim',
            'dockerfile',
            'terraform',
            'cpp',
            'c',
            'javascript',
            'yaml',
            'markdown',
            'markdown_inline',
            'html',
        }

        -- Enable treesitter highlighting for installed parsers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                'python', 'rust', 'hcl', 'lua', 'vim', 'dockerfile',
                'terraform', 'cpp', 'c', 'javascript', 'yaml',
                'markdown', 'html',
            },
            callback = function() vim.treesitter.start() end,
        })

        -- Markdown link navigation
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.keymap.set('n', 'gf', function()
                    local line = vim.api.nvim_get_current_line()
                    local link = line:match('%[.-%]%(([^)]+)%)')

                    if not link then
                        vim.notify('No markdown link found', vim.log.levels.WARN)
                        return
                    end

                    -- Remove anchor
                    link = link:gsub('#.*$', '')

                    -- Get the directory of the CURRENT FILE, not pwd
                    local current_file = vim.fn.expand('%:p')
                    local current_dir = vim.fn.fnamemodify(current_file, ':h')

                    local full_path = vim.fn.simplify(current_dir .. '/' .. link)

                    if vim.fn.filereadable(full_path) == 1 then
                        vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
                    else
                        vim.notify('File not found!\nLooking for: ' .. full_path .. '\nCurrent file: ' .. current_file, vim.log.levels.ERROR)
                    end
                end, { buffer = true, silent = false, noremap = true })

                -- Map Enter to gf
                vim.keymap.set('n', '<CR>', 'gf', { buffer = true, remap = true })
            end,
        })
    end
}
