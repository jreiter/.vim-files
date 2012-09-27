" markdown filetype file

if exists("did\_load\_filetypes")

 finish

endif

augroup markdown

 au! BufRead,BufNewFile *.mkd   setfiletype mkd

augroup END

augroup gradle

 au! BufRead,BufNewFile *.gradle setfiletype groovy

augroup END
