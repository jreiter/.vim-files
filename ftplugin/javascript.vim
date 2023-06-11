setlocal shiftwidth=2
setlocal tabstop=2
setlocal textwidth=80

"Display ruler at 80 characters
if exists('+colorcolumn')
  setlocal colorcolumn=80
endif

autocmd BufWrite *_spec.js lua require('neotest').run.run(vim.fn.expand('%'))
