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
  should_attach = function(bufnr)
    return not vim.api.nvim_buf_get_name(bufnr):match('^octo://')
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
})
