setlocal textwidth=80

setlocal shiftwidth=2
setlocal tabstop=2

autocmd BufWrite *.rb lua require('neotest').run.run(vim.fn.expand('%'))
