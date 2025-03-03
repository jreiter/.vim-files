local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.sorbet.setup({
	capabilities = capabilities,
	filetypes = { "ruby" },
})

lspconfig.ruby_lsp.setup({
	capabilities = capabilities,
	filetypes = { "ruby" },
	on_attach = function(client)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})
