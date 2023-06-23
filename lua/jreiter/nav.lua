require('oil').setup({
  view_options = { show_hidden = true }
})

vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })

require('leap').add_default_mappings()
