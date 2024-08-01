return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = { auto_attach = true },
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = "󰠱 ",
        Method = "󰊕 ",
        Property = "󰜢 ",
        Field = "󰇽 ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = "󰊕 ",
        Variable = "󰂡 ",
        Constant = "󰏿 ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰠱 ",
        Event = " ",
        Operator = " ",
        TypeParameter = " "
      }
    },
    "bkad/CamelCaseMotion",
  }
}
