local neotest = require('neotest')

neotest.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = 'npm test --',
    }),
    require('neotest-rspec')({
      rspec_cmd = function()
        return vim.tbl_flatten({
          'bundle',
          'exec',
          'rspec',
        })
      end
    }),
    require('neotest-vim-test')({
      ignore_file_types = { 'javascript', 'ruby' },
    }),
  },
  output_panel = {
    enabled = false
  }
})
