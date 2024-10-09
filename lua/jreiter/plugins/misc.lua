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
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "voldikss/vim-floaterm",
    keys = {
      { "<F1>", "<cmd>FloatermNew<cr>", desc = "New floating terminal"},
      { "<F2>", "<cmd>FloatermPrev<cr>", desc = "Previous floating terminal"},
      { "<F3>", "<cmd>FloatermNext<cr>", desc = "Next floating terminal"},
      { "<F4>", "<cmd>FloatermToggle<cr>", desc = "Toggle floating terminal"},
    }
  },
  {
  "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  }
}
