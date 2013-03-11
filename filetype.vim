" markdown filetype file

if exists("did\_load\_filetypes")

 finish

endif

augroup markdown

 au! BufRead,BufNewFile *.md   setfiletype mkd

augroup END

augroup gradle

 au! BufRead,BufNewFile *.gradle setfiletype groovy

augroup END

augroup nsis

 au! BufRead,BufNewFile *.nsh setfiletype nsis
 au! BufRead,BufNewFile *.nsis setfiletype nsis

augroup END
