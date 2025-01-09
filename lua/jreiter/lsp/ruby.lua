local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.rubocop.setup{
  capabilities = capabilities,
  filetypes = { "ruby" },
  on_attach = function()
    vim.cmd([[
    augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
    augroup END
    ]])
  end,
}

lspconfig.sorbet.setup{
  capabilities = capabilities,
  filetypes = { "ruby" },
}

lspconfig.ruby_lsp.setup{
  capabilities = capabilities,
  filetypes = { "ruby" },
}
