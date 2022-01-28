local ultest = require('ultest')

ultest.setup({
  builders = {
    ['javascript#jest'] = function (cmd)
      -- The command starts with the jest executable, so we want --inspect-brk
      -- before that
      table.insert(cmd, 1, '--inspect-brk')
      table.insert(cmd, 3, '--watchAll=false')
      return {
        dap = {
          type = 'node2',
          request = 'launch',
          cwd = vim.fn.getcwd(),
          runtimeArgs = cmd,
          args =  { '--no-cache' },
          sourceMaps = true,
          protocol = 'inspector',
          outputCapture = 'std',
          port = 9229,
          disableOptimisticBps = true,
          skipFiles = {'<node_internals>/**/*.js'},
        },
        parse_result = function(lines)
          local summary = lines[#lines-4]
          local failed = tonumber(string.match(summary, '(%d) failed'))
          if (failed == nil) then
            failed = 0
          end
          return failed > 0 and 1 or 0
        end
      }
    end
  }
})
