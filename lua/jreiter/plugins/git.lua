return {
	"lewis6991/gitsigns.nvim",
	{
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
			use_icons = true,
			file_history_panel = {
				log_options = {
					git = {
						single_file = {
							follow = true,
						},
					},
				},
			},
		},
	},
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"pwntester/octo.nvim",
		opts = { enable_builtin = true },
	},
}
