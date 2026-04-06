return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].syntax = ""
					end
				end,
			})
		end,
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
				"gotmpl",
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
