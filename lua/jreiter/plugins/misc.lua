return {
  "bfredl/nvim-miniyank",
  "echasnovski/mini.pairs",
  "echasnovski/mini.bracketed",
  "godlygeek/tabular",
  "tpope/vim-abolish",
  "tpope/vim-projectionist",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        }
      },
      presets = {
        inc_rename = true,
      }
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
}
