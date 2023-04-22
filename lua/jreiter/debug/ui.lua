local dap, dapui = require('dap'), require('dapui')

dapui.setup({
  layouts = {
    {
      elements = {
        -- {
        --   id = "scopes",
        --   size = 0.25
        -- },
        -- {
        --   id = "breakpoints",
        --   size = 0.25
        -- },
        -- {
        --   id = "stacks",
        --   size = 0.25
        -- },
        -- {
        --   id = "watches",
        --   size = 0.25
        -- }
      },
      position = "left",
      size = 40
    },
    {
      elements = {
        -- {
        --   id = "repl",
        --   size = 0.5
        -- },
        {
          id = "console",
          size = 0.5
        }
      },
      position = "bottom",
      size = 10
    }
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
