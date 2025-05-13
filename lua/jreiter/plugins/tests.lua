return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
			"marilari88/neotest-vitest",
			"fredrikaverpil/neotest-golang",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-vim-test",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
			"olimorris/neotest-rspec",
			"suketa/nvim-dap-ruby",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			-- vim.diagnostic.config({
			-- 	virtual_text = {
			-- 		format = function(diagnostic)
			-- 			-- Replace newline and tab characters with space for more compact diagnostics
			-- 			local message =
			-- 				diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			-- 			return message
			-- 		end,
			-- 	},
			-- }, neotest_ns)

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
					require("neotest-golang")({}),
					require("neotest-rspec")({}),
					require("neotest-vim-test")({
						ignore_file_types = { "javascript", "ruby" },
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
