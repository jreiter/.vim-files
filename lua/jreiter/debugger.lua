local dap_install = require('dap-install')

dap_install.setup({
  installation_path = vim.fn.stdpath('data') .. '/dapinstall/',
})

local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end

require('dapui').setup({
  sidebar = {
    elements = {}
  },
  tray = {
    elements = { "repl" },
    size = 15,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
})

--require("nvim-dap-virtual-text").setup()
