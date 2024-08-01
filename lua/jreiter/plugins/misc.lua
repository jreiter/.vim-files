return {
  "bfredl/nvim-miniyank",
  "echasnovski/mini.pairs",
  "echasnovski/mini.bracketed",
  "tpope/vim-abolish",
  "tpope/vim-endwise",
  "tpope/vim-projectionist",
  "tpope/vim-repeat",
  "tpope/vim-surround",
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
