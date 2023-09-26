setlocal spell

function! DebugCucumberJsTransform(cmd) abort
  let original_cmd = split(a:cmd, ' ')
  let debug_cmd = ['node --inspect-brk', original_cmd[0], '--', original_cmd[1]]
  return join(debug_cmd)
endfunction

" let g:test#custom_transformations = {'debug_cucumber_js': function('DebugCucumberJsTransform')}
" let g:test#transformation = 'debug_cucumber_js'
