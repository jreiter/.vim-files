local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.solargraph.setup{
  capabilities = capabilities,
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      diagnostics = false,
      formatting = false,
      folding = true,
      checkGemVersion = false,
      useBundler = true,
      bundlePath = vim.fn.expand("~/.rbenv/shims/bundle"),
    },
  },
  on_attach = function()
    vim.cmd([[
    augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
    augroup END
    ]])
  end,
}

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
