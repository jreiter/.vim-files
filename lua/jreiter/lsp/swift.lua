vim.lsp.config("sourcekit", {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
		textDocument = {
			inlayHints = {
				enable = false,
			},
			diagnostic = {
				dynamicRegistration = true,
				relatedDocumentSupport = true,
			},
		},
	},
})
vim.lsp.enable("sourcekit")
