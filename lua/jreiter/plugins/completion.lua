return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = "make install_jsregexp",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			local luasnip = require("luasnip")
			luasnip.filetype_extend("ruby", { "rails" })
			luasnip.filetype_extend("typescript", { "tsdoc", "react-ts", "javascript" })
			luasnip.filetype_extend("typescriptreact", { "tsdoc", "react-ts", "javascript" })
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
			},
		},
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				menu = {
					auto_show = true,
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			snippets = {
				preset = "luasnip",
			},
		},
		opts_extend = { "sources.default" },
	},
}
