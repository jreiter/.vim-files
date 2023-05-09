local dap_install = require('dap-install')

dap_install.setup({
  installation_path = vim.fn.stdpath('data') .. '/dapinstall/',
})

local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end


vim.fn.sign_define('DapBreakpoint', {text=''})
vim.fn.sign_define('DapBreakpointCondition', {text=''})
vim.fn.sign_define('DapLogPoint', {text=''})
vim.fn.sign_define('DapStopped', {text=''})
vim.fn.sign_define('DapBreakpointRejected', {text=''})

require('nvim-dap-virtual-text').setup()


-- Completion

require('cmp').setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
        or require('cmp_dap').is_dap_buffer()
  end
})

require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
  sources = {
    { name = 'dap' },
  },
})
