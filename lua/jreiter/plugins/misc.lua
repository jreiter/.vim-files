return {
  "bfredl/nvim-miniyank",
  "echasnovski/mini.pairs",
  "echasnovski/mini.bracketed",
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
    opts = {
      lsp = {
        signature = {
          enabled = false,
        }
      },
      presets = {
        inc_rename = true,
      }
    }
  },
}
