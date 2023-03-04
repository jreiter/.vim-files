local dap = require('dap')

require('dap-vscode-js').setup({
  adapters = { "pwa-node" },
  debugger_path = '/Users/johnathanreiter/workspace/open_source/vscode-js-debug'
})

dap.configurations.javascript = {
  {
    name = 'launch process',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'attach to process',
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'attach to remote process',
    type = 'node2',
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
