setlocal shiftwidth=4
setlocal tabstop=4

nnoremap <silent> <buffer> <leader>d :YcmCompleter GetDoc<cr>
nnoremap <silent> <buffer> <leader>y :YcmCompleter GetType<cr>
nnoremap <silent> <buffer> <leader>g :YcmCompleter GoToReferences<cr>
nnoremap <silent> <buffer> <leader>r :YcmCompleter RefactorRename
nnoremap <silent> <buffer> <cr> :YcmCompleter GoToDefinition<cr>
