return {
	{
		"github/copilot.vim",
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
		keys = {
			{ "<leader>ccc", "<cmd>CodeCompanionChat<CR>", desc = "Chat" },
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)
			require("jreiter.plugins.custom.spinner"):init()
		end,
		opts = {
			strategies = {
				chat = {
					adapter = "claude_code",
				},
				inline = {
					adapter = "claude_code",
				},
				agent = {
					adapter = "claude_code",
				},
			},
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "gpt-4.1",
								},
							},
						})
					end,
					acp = {
						claude_code = function()
							return require("codecompanion.adapters").extend("claude_code", {
								env = {
									CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
								},
							})
						end,
					},
				},
			},
		},
	},
}
