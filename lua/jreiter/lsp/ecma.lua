local api = require("typescript-tools.api")

require("typescript-tools").setup({
	root_dir = function(fname_or_bufnr)
		-- Handle both filename string and buffer number
		local fname
		if type(fname_or_bufnr) == "number" then
			fname = vim.api.nvim_buf_get_name(fname_or_bufnr)
		else
			fname = fname_or_bufnr
		end

		-- Don't attach LSP to diff buffers
		if fname:match("_diff_") then
			return nil
		end

		-- Use default root_dir detection for normal files
		return require("typescript-tools.config").default_config.root_dir(fname)
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
	root_dir = function(fname_or_bufnr)
		-- Handle both filename string and buffer number
		local fname
		if type(fname_or_bufnr) == "number" then
			fname = vim.api.nvim_buf_get_name(fname_or_bufnr)
		else
			fname = fname_or_bufnr
		end

		-- Don't attach LSP to diff buffers
		if fname:match("_diff_") then
			return nil
		end

		-- Use default root_dir detection for normal files
		return vim.fs.root(fname, {
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
	end,
}

vim.lsp.enable("eslint")
