local dap = require('dap')

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
