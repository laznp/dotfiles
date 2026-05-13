-- ─── mason ────────────────────────────────────────────────────────────────────
local mason_tools = { "ruff", "rust-analyzer", "bash-language-server", "terraform-ls", "clangd" }
require("mason").setup()

vim.api.nvim_create_user_command('MasonInstallLocal', function()
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
        vim.defer_fn(function()
            vim.api.nvim_exec_autocmds("FileType", { buf = vim.api.nvim_get_current_buf() })
        end, 100)
    end)
    mr.refresh(function()
        for _, tool in ipairs(mason_tools) do
            local p = mr.get_package(tool)
            if not p:is_installed() then p:install() end
        end
    end)
end, {})

-- ─── diagnostics ─────────────────────────────────────────────────────────────
local diag_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(diag_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    float = { border = 'rounded', source = 'if_many' },
    signs = true,
})

-- ─── servers ──────────────────────────────────────────────────────────────────
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_servers = {
    ruff = {
        cmd = { 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    },
    rust_analyzer = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'Cargo.lock' },
    },
    bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'bash', 'sh' },
        root_markers = { '.git' },
    },
    clangd = {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
    },
    terraformls = {
        cmd = { 'terraform-ls', 'serve' },
        filetypes = { 'terraform', 'hcl', 'terraform-vars' },
        root_markers = { '.terraform', '.git' },
    },
}

vim.lsp.config('*', { capabilities = capabilities })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('native_lsp', { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,    opts)
        vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,   opts)
        vim.keymap.set('n', 'gr',         vim.lsp.buf.references,    opts)
        vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,opts)
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover,         opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename,        opts)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action,   opts)
        vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,  opts)
        vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,  opts)
        vim.keymap.set('n', '<Leader>d',  vim.diagnostic.open_float, opts)
    end,
})

for name, config in pairs(lsp_servers) do
    vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(lsp_servers))
