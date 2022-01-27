local dap = require('dap')

dap.configurations.typescript = {
  {
    name = 'sst start',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/sst',
    args = { 'start', '--increase-timeout'},
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    -- outFiles = {'${workspaceFolder}/**/*.js'},
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'sst tests',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/sst',
    args = {'test', '--runInBand', '--no-cache', '--watchAll=false'},
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    disableOptimisticBPs = true,
    -- outFiles = {'${workspaceFolder}/**/*.js'},
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
