-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').solargraph.setup{
  capabilities = capabilities,
  filetypes = { 'ruby' },
  settings = {
    solargraph = {
      checkGemVersion = false,
      diagnostics = true,
      folding = false,
      bundlePath = '/Users/reiterj/.rbenv/shims/bundle',
      useBundler = true,
    },
  },
}
require('lspconfig').tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

require('lspsaga').init_lsp_saga()
