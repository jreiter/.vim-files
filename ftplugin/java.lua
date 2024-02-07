local config = {
  cmd = {'jdtls'},
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}

local jdtls = require('jdtls')
jdtls.start_or_attach(config)

vim.keymap.set('n', '<Leader>i', function()
  jdtls.organize_imports()
end, { noremap = true, silent = true })
