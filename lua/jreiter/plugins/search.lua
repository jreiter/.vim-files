return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      "nvim-telescope/telescope-media-files.nvim",
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
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
      }
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      });
    end
  },
}
