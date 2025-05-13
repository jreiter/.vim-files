return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				opts = {},
				config = function(_, _)
					local dap = require("dap")
					local dapui = require("dapui")

					dapui.setup({
						layouts = {
							{
								elements = {},
								position = "left",
								size = 40,
							},
							{
								elements = {
									{
										id = "console",
										size = 0.5,
									},
									{
										id = "repl",
										size = 0.5,
									},
								},
								position = "bottom",
								size = 10,
							},
						},
					})

					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end

					require("jreiter.debug")
				end,
			},
			"theHamsta/nvim-dap-virtual-text",
			"suketa/nvim-dap-ruby",
			"leoluz/nvim-dap-go",
			{
				"mxsdev/nvim-dap-vscode-js",
				dependencies = {
					{
						"microsoft/vscode-js-debug",
						commit = "4d7c704d3f07",
						build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
					},
				},
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				opts = {
					-- Makes a best effort to setup the various debuggers with
					-- reasonable debug configurations
					automatic_installation = true,

					-- You can provide additional configuration to the handlers,
					-- see mason-nvim-dap README for more information
					handlers = {},

					-- You'll need to check that you have the required things installed
					-- online, please don't ask me how to install them :)
					ensure_installed = { "delve" },
				},
			},
		},
	},
}
