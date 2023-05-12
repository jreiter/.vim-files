local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.formatting.eslint_d,
  },
  -- you can reuse a shared lspconfig on_attach callback here
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
})

-- Use lsp-lines instead of virtual text for diagnostics

require('lsp_lines').setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
})
