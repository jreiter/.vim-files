-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
    end
  end,
}
require('lspconfig').tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}

require('lspconfig').sumneko_lua.setup{}
require('lspsaga').init_lsp_saga()
