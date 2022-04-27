-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').solargraph.setup{
  capabilities = capabilities,
  filetypes = { 'ruby' },
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      folding = true,
      checkGemVersion = false,
      useBundler = true,
      bundlePath = vim.fn.expand('~/.rbenv/shims/bundle'),
    },
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
}
require('lspconfig').tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

require('lspsaga').init_lsp_saga()
