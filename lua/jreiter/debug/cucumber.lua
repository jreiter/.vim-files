local dap = require('dap')

require('dap-vscode-js').setup({
  adapters = { "pwa-node" },
  debugger_path = '/Users/johnathanreiter/workspace/open_source/vscode-js-debug'
})

dap.configurations.cucumber = {
  {
    name = 'attach to process',
    type = 'pwa-node',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
}
