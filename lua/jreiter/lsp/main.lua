-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspConfig = require('lspconfig')

lspConfig.solargraph.setup{
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
  on_attach = function()
    vim.cmd([[
    augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
    augroup END
    ]])
  end,
}

lspConfig.tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    require('lsp-inlayhints').on_attach(client, bufnr)
  end,
  settings = {
    diagnostics = {
      ignoredCodes = {
        80001, -- Allow CommonJS modules
        7016, -- Allow untyped modules
      },
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  },
}

local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {'helm_ls', 'serve'},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspConfig.helm_ls.setup {
  filetypes = {'helm'},
  cmd = {'helm_ls', 'serve'},
}

lspConfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      }
    }
  }
})
require('lspsaga').init_lsp_saga()
require('lsp-inlayhints').setup()
