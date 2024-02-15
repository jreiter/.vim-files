local dap = require('dap')

require('dap-vscode-js').setup({
  adapters = { "pwa-node" },
  debugger_path = os.getenv('HOME') .. '/workspace/open_source/vscode-js-debug'
})

dap.configurations.javascript = {
  {
    name = 'launch process',
    type = 'pwa-node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'attach to process',
    type = 'pwa-node',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    skipFiles = {'<node_internals>/**/*.js'},
  },
}

dap.configurations.typescript = {
  {
    name = 'Launch Current File (pwa-node with ts-node)',
    type = 'pwa-node',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = { '--loader', 'ts-node/esm' },
    runtimeExecutable = 'node',
    args = { '${file}' },
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
    resolveSourceMapLocations = {
      '${workspaceFolder}/**',
      '!**/node_modules/**',
    },
  },
  {
    name = 'attach to process',
    type = 'pwa-node',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    skipFiles = {'<node_internals>/**/*.js'},
  },
}
