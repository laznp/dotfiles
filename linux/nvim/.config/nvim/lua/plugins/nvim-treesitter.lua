return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
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
            },
            indent = {
                enable = true,
                disable = {'python'}
            },
            highlight = {
                enable = true,
                disable = {'gitignore'},
            },
            autopairs = {
                enable = true
            },
            additional_vim_regex_highlighting = false,
        }
        
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
                    
                    -- IMPORTANT: Get the directory of the CURRENT FILE, not pwd
                    local current_file = vim.fn.expand('%:p')  -- Full path of current file
                    local current_dir = vim.fn.fnamemodify(current_file, ':h')  -- Directory of current file
                    
                    -- Build absolute path
                    local full_path = vim.fn.simplify(current_dir .. '/' .. link)
                    
                    -- Try to open
                    if vim.fn.filereadable(full_path) == 1 then
                        vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
                    else
                        -- Show debug info
                        vim.notify('File not found!\nLooking for: ' .. full_path .. '\nCurrent file: ' .. current_file, vim.log.levels.ERROR)
                    end
                end, { buffer = true, silent = false, noremap = true })
                
                -- Map Enter to gf
                vim.keymap.set('n', '<CR>', 'gf', { buffer = true, remap = true })
            end,
        })
    end
}
