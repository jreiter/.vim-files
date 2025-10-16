local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.sorbet = {
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	capabilities = capabilities,
}

vim.lsp.config.ruby_lsp = {
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	capabilities = capabilities,
}

vim.lsp.enable("sorbet")
vim.lsp.enable("ruby_lsp")
