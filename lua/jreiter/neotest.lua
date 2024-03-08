local neotest = require('neotest')

local neotest_jest = require('neotest-jest')({
  jestCommand = 'npm test --'
})
neotest_jest.filter_dir = function (name)
  return name ~= 'node_modules' or name ~= '__snapshots__'
end

local neotest_vitest = require('neotest-vitest')
neotest_vitest.filter_dir = function (name)
  return name ~= 'node_modules' or name ~= '__snapshots__'
end

neotest.setup({
  adapters = {
    neotest_jest,
    neotest_vitest,
    require('neotest-rspec')({}),
    require('neotest-vim-test')({
      ignore_file_types = { 'javascript', 'ruby' },
    }),
  },
  output_panel = {
    enabled = true,
    open = "botright split | resize 15"
  },
  quickfix = {
    open = false,
  },
  status = {
    signs = false,
    virtual_text = true,
  }
})
