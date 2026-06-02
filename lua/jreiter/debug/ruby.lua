require('dap-ruby').setup()

local dap = require('dap')
local original_adapter = dap.adapters.ruby

-- nvim-dap defaults to 14 retries × 250ms = 3.5s, which isn't enough for Rails cold start.
-- Wrap the adapter to bump max_retries to 120 (30s window).
dap.adapters.ruby = function(callback, config)
  original_adapter(function(resolved)
    if resolved.type == "server" then
      resolved.options = vim.tbl_extend("force", resolved.options or {}, { max_retries = 120 })
    end
    callback(resolved)
  end, config)
end
