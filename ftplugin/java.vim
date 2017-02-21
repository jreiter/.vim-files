nnoremap <silent> <buffer> <leader>i :JavaImportOrganize<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

"Indent 4 spaces rather than the default 2
setlocal tabstop=4 shiftwidth=4 expandtab
