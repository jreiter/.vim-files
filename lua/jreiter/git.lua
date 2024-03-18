require('diffview').setup({
  enhanced_diff_hl = true,
  use_icons = true,
  file_history_panel = {
    log_options = {
      git = {
        single_file = {
          follow = true
        }
      }
    }
  }
})

require('octo').setup({ enable_builtin = true})
require('gitsigns').setup()

vim.keymap.set('', '<Leader>O', '<cmd>Octo<cr>', { desc = 'Octo commands' })
