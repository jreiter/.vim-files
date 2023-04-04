require('oil').setup()

vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })

require('leap').add_default_mappings()
