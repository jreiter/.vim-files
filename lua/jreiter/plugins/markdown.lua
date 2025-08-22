return {
	{
		"ellisonleao/glow.nvim",
		opts = {
			width_ratio = 0.8,
			height_ratio = 0.9,
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
