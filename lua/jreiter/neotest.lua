local neotest = require('neotest')

local neotest_jest = require('neotest-jest')({
  jestCommand = 'npm test --'
})
neotest_jest.filter_dir = function (name)
  return name ~= 'node_modules' and name ~= '__snapshots__'
end

neotest.setup({
  adapters = {
    neotest_jest,
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
  }
})
