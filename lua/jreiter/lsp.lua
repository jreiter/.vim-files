-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').solargraph.setup{
  capabilities = capabilities,
  filetypes = { 'ruby' },
  settings = {
    solargraph = {
      checkGemVersion = true,
      diagnostics = true,
      folding = false,
      useBundler = true,
    },
  },
}
require('lspconfig').tsserver.setup{
  capabilities = capabilities
}

require('lspsaga').init_lsp_saga()
