return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"css",
				"dockerfile",
				"git_config",
				"gitattributes",
				"go",
				"graphql",
				"html",
				"http",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"kotlin",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"mermaid",
				"pem",
				"php",
				"python",
				"query",
				"regex",
				"ruby",
				"rust",
				"scss",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vue",
				"yaml",
			},
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			function _G.javascript_indent()
				local line = vim.fn.getline(vim.v.lnum)
				local prev_line = vim.fn.getline(vim.v.lnum - 1)
				if line:match("^%s*[%*/]%s*") then
					if prev_line:match("^%s*%*%s*") then
						return vim.fn.indent(vim.v.lnum - 1)
					end
					if prev_line:match("^%s*/%*%*%s*$") then
						return vim.fn.indent(vim.v.lnum - 1) + 1
					end
				end

				return vim.fn["GetJavascriptIndent"]()
			end

			vim.cmd([[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]])

			if load_textobjects then
				local Loader = require("lazy.core.loader")
				Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
				local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
				require("lazy.core.loader").source_runtime(plugin.dir, "plugin")

				require("nvim-treesitter.configs").setup({
					textobjects = {
						swap = {
							enable = true,
							swap_next = {
								["<leader>a"] = "@parameter.inner",
							},
							swap_previous = {
								["<leader>A"] = "@parameter.inner",
							},
						},
					},
				})
			end
		end,
		dependencies = {
			"nvim-treesitter/playground",
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					load_textobjects = true
				end,
			},
		},
	},
	{
		"danymat/neogen",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"andymass/vim-matchup",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
