local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require'lspconfig'.ansiblels.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.jsonls.setup { capabilities = capabilities }
-- require'lspconfig'.pylsp.setup{}
-- require'lspconfig'.rust_analyzer.setup{}
-- require'lspconfig'.terraformls.setup{}
require'lspconfig'.yamlls.setup{}
