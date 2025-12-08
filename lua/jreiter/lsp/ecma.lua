local api = require("typescript-tools.api")
local capabilities = require("blink.cmp").get_lsp_capabilities()

require("typescript-tools").setup({
	capabilities = capabilities,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- Don't attach LSP to diff buffers
		if fname:match("_diff_") then
			on_dir(nil)
			return
		end

		-- Use default root_dir detection for normal files
		local root = vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
		on_dir(root)
	end,
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

vim.lsp.config.eslint = {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc.json",
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"package.json",
	},
	capabilities = capabilities,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- Don't attach LSP to diff buffers
		if fname:match("_diff_") then
			on_dir(nil)
			return
		end

		-- Use default root_dir detection for normal files
		local root = vim.fs.root(fname, {
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"package.json",
		})
		on_dir(root)
	end,
}

vim.lsp.enable("eslint")
