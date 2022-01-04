local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local telescope = require('telescope')

-- https://github.com/nvim-telescope/telescope.nvim
telescope.setup({
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '  ',
    entry_prefix = '  ',
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
    file_ignore_patterns = {
      '%.har$',
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-n>'] = actions.cycle_history_next,
      },
    },
  },
})

telescope.load_extension('fzf')
