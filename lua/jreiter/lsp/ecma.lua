local api = require("typescript-tools.api")

require("typescript-tools").setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
	handlers = {
		["textDocument/publishDiagnostics"] = api.filter_diagnostics(
			-- Ignore 'This may be converted to an async function' diagnostics.
			{
				80001, -- Allow CommonJS modules
				7016, -- Allow untyped modules
			}
		),
	},
	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "none",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = false,
			includeInlayVariableTypeHints = false,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = false,
			includeInlayFunctionLikeReturnTypeHints = false,
			includeInlayEnumMemberValueHints = false,
		},
	},
})

require("lspconfig").eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
