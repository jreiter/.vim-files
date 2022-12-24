local neotest = require('neotest')

neotest.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = 'npm test --',
    }),
    require('neotest-rspec'),
    require('neotest-vim-test')({
      ignore_file_types = { 'javascript', 'ruby' },
    }),
  },
})
