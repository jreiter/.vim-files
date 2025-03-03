return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"pmizio/typescript-tools.nvim",
			"mfussenegger/nvim-jdtls",
			{
				"ray-x/go.nvim",
				dependencies = {
					"ray-x/guihua.lua",
					"neovim/nvim-lspconfig",
					"nvim-treesitter/nvim-treesitter",
				},
				config = function()
					require("go").setup()
				end,
				event = { "CmdlineEnter" },
				ft = { "go", "gomod" },
				build = ':lua require("go.install").update_all_sync()',
			},
			{
				"folke/trouble.nvim",
				keys = {
					{ "<leader>xx", "<cmd>TroubleToggle<cr>" },
					{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
					{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
					{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
					{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
				},
			},
		},
		config = function()
			require("jreiter.lsp")
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"dockerfile-language-server",
				"eslint_d",
				"hadolint",
				"nginx-language-server",
				"shellcheck",
				"stylua",
				"typescript-language-server",
				"gopls",
			},
		},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		lazy = false,
		keys = {
			{ "<leader>il", '<cmd>lua require("lsp-inlayhints").toggle()<CR>' },
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			floating_window = true,
			-- hint_inline = function() return true end,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				show_source = true,
				use_icons_from_diagnostic = true,
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
		dependencies = {
			"folke/noice.nvim",
		},
	},
}
