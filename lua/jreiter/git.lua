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
