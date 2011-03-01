colorscheme desert

"set tabs to 4 spaces, soft
set tabstop=4 shiftwidth=4 expandtab
"line numbers
set number
"ignore case on searches
set ic

"turn off toolbar and menu
set guioptions-=m
set guioptions-=T

"wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.class,*.git

"leader key
let mapleader = ","

"Freemarker highlighting
au BufRead,BufNewFile *.ftl set filetype=ftl
au! Syntax ftl source /home/jreiter/.vim/syntax/ftl.vim

"Markdown highlighting
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

"
filetype plugin on

"eclim options
"let g:EclimJavaCompilerAutoDetect = 0
let g:EclimProjectTreeSharedInstance = 1
let g:EclimLocateFileScope = 'workspace'

"make w, b, and e use CamelCaseMotion
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b
map <silent>e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

"fuzzyfinder options
let g:fuzzy_ceiling = 40000

"leader key
let mapleader = ","

let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{},
      \                      'MruFile':{}, 'MruCmd':{}, 'Bookmark':{},
      \                      'Tag':{}, 'TaggedFile':{},
      \                      'GivenFile':{}, 'GivenDir':{},
      \                      'CallbackFile':{}, 'CallbackItem':{}, }

let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.class$'

nmap <silent> <Leader>t :FufFile **/<CR>
nmap <silent> <Leader>r :LocateFile<CR>

"Command-t mapping to ,t
"nmap <silent> <Leader>t :CommandT<CR>
nmap <silent> <Leader>nt :NERDTreeToggle<CR>

"remove trailing whitespace with F5
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"highlight trailing white space in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"user-defined functions

":PrettyXML command
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
