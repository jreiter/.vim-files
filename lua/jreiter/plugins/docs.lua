return {
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      previewer_cmd = 'glow',
      cmd_args = { '-s', 'dark', '-w', '80' },
      picker_cmd = 'glow',
      picker_cmd_args = { '-s', 'dark', '-w', '80' },
    }
  }
}
