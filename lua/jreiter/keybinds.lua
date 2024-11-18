vim.cmd([[
" Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>
" DAP
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.step_back()<CR>
nnoremap <silent> <F10> :lua require'dap'.close()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>E :lua require'dap'.set_exception_breakpoints()<CR>
nnoremap <silent> <leader>dr :lua require'dapui'.float_element('repl', { width = 100, height = 40, enter = true })<CR>
nnoremap <silent> <leader>ds :lua require'dapui'.float_element('scopes', { width = 150, height = 50, enter = true })<CR>
nnoremap <silent> <leader>df :lua require'dapui'.float_element('stacks', { width = 150, height = 50, enter = true })<CR>
nnoremap <silent> <leader>db :lua require'dapui'.float_element('breakpoints', { enter = true })<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
" neotest
nmap <silent> t<C-d> :lua require('neotest').run.run({strategy = 'dap'})<CR>
nmap <silent> t<C-n> :lua require('neotest').run.run()<CR>
nmap <silent> t<C-f> :lua require('neotest').run.run(vim.fn.expand('%'))<CR>
nmap <silent> t<C-s> :lua require('neotest').summary.open()<CR>
nmap <silent> t<C-o> :lua require('neotest').output_panel.toggle()<CR>
" devdocs
nnoremap <silent> <leader>dd :DevdocsOpenFloat<CR>
nnoremap <silent> <leader>dc :DevdocsOpenCurrentFloat<CR>
" telescope
nnoremap <silent> <Leader>t :Telescope find_files<CR>
nnoremap <space>f :Telescope live_grep<CR>
nnoremap <space>s :Telescope buffers<CR>
nnoremap <space>o :Telescope lsp_document_symbols<CR>
" trouble
nnoremap <leader>qt :Trouble diagnostics<cr>
nnoremap <leader>qf :copen<cr>
" copying to os clipboard
map <leader>y "*y
map <leader>Y "+y
" miniyank settings
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)
" GoTo code navigation.
nmap <silent> gd :Telescope lsp_definitions<CR>
nmap <silent> gy :Telescope lsp_type_definitions<CR>
nmap <silent> gi :Telescope lsp_implementations<CR>
nmap <silent> gr :Telescope lsp_references<CR>
nmap <silent> <CR> :lua vim.lsp.buf.hover()<CR>
" make w, b, and e use CamelCaseMotion
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b
map <silent>e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
" exit terminal mode more easily
tnoremap jk <c-\><c-n>
" tabular bindings
map <Leader>a= :Tabularize /=<CR>
map <Leader>a: :Tabularize /:\zs<CR>
map <Leader>a, :Tabularize /,\zs<CR>
" base64 decode
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>
"vista binding
nmap <silent> <Leader>v :Vista!!<CR>
]])

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('', '<Leader>O', '<cmd>Octo<cr>', { desc = 'Octo commands' })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
