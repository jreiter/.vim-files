require("go").setup({})
vim.lsp.enable("gopls")

-- Configure golangci-lint-ls with v2.x command format
vim.lsp.config("golangci_lint_ls", {
	cmd = { "golangci-lint-langserver", "-debug" },
	filetypes = { "go", "gomod" },
	root_markers = { "go.mod", ".golangci.yml", ".git" },
	init_options = {
		command = {
			"golangci-lint",
			"run",
			"--output.json.path=stdout",
			"--show-stats=false",
			"--issues-exit-code=1",
		},
	},
})
vim.lsp.enable("golangci_lint_ls")
