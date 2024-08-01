return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        layouts = {
          {
            elements = {},
            position = "left",
            size = 40
          },
          {
            elements = {
              {
                id = "console",
                size = 0.5
              }
            },
            position = "bottom",
            size = 10
          }
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end

          require("jreiter.debug")
        end,
      },
      "theHamsta/nvim-dap-virtual-text",
      "Pocco81/dap-buddy.nvim",
      {
        "Pocco81/DAPInstall.nvim",
        opts = {
          installation_path = vim.fn.stdpath('data') .. '/dapinstall/',
        },
        config = function()
          -- local dap_install = require('dap-install')
          -- local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()
          --
          -- for _, debugger in ipairs(dbg_list) do
          --   dap_install.config(debugger)
          -- end

          vim.fn.sign_define('DapBreakpoint', {text=''})
          vim.fn.sign_define('DapBreakpointCondition', {text=''})
          vim.fn.sign_define('DapLogPoint', {text=''})
          vim.fn.sign_define('DapStopped', {text=''})
          vim.fn.sign_define('DapBreakpointRejected', {text=''})

          require('cmp').setup({
            enabled = function()
              return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
                  or require('cmp_dap').is_dap_buffer()
            end
          })

          require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
            sources = {
              { name = 'dap' },
            },
          })
        end,
      },
      "suketa/nvim-dap-ruby",
      {
        "mxsdev/nvim-dap-vscode-js",
        adapters = { "pwa-node" },
        debugger_path = os.getenv('HOME') .. '/workspace/open_source/vscode-js-debug'
      }
    },
  },
}
