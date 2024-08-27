require("jreiter.lazy")
require("jreiter.options")
require("jreiter.colorscheme")
require("jreiter.globals")
require("jreiter.keybinds")

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})
