setlocal shiftwidth=2
setlocal tabstop=2
setlocal textwidth=80

"Display ruler at 80 characters
if exists('+colorcolumn')
  setlocal colorcolumn=80
endif

nnoremap <silent> <buffer> <leader>d :YcmCompleter GetDoc<cr>
nnoremap <silent> <buffer> <leader>y :YcmCompleter GetType<cr>
nnoremap <silent> <buffer> <leader>g :YcmCompleter GoToReferences<cr>
nnoremap <silent> <buffer> <leader>r :YcmCompleter RefactorRename
nnoremap <silent> <buffer> <cr> :YcmCompleter GoToDefinition<cr>
