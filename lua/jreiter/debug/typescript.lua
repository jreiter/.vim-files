local dap = require('dap')

dap.configurations.typescript = {
  {
    name = 'launch process',
    type = 'pwa-node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'attach to process',
    type = 'pwa-node',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'attach to remote process',
    type = 'pwa-node',
    request = 'attach',
    address = '127.0.0.1',
    port = '9229',
    localRoot = vim.fn.getcwd(),
    remoteRoot = '/froggy/src',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
}
