return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
			"marilari88/neotest-vitest",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
			"olimorris/neotest-rspec",
			"suketa/nvim-dap-ruby",
			{
				"fredrikaverpil/neotest-golang",
				commit = "ad6ae703e18874eb66fee539224eac2dd9cc0890",
			},
		},
		config = function()
			local neotest_jest = require("neotest-jest")({
				jestCommand = "npm test --",
			})
			neotest_jest.filter_dir = function(name)
				return name ~= "node_modules" or name ~= "__snapshots__"
			end

			local neotest_vitest = require("neotest-vitest")
			neotest_vitest.filter_dir = function(name)
				return name ~= "node_modules" or name ~= "__snapshots__"
			end

			require("neotest").setup({
				adapters = {
					neotest_jest,
					neotest_vitest,
					require("neotest-rspec"),
					require("neotest-golang")({
						go_test_args = {
							"-v",
							"-race",
							"-count=1",
						},
					}),
				},
				output_panel = {
					enabled = true,
					open = "botright split | resize 15",
				},
				quickfix = {
					open = false,
				},
				status = {
					signs = false,
					virtual_text = true,
				},
			})
		end,
	},
}
