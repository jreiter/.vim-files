runtime pathogen_init

"colors
syntax enable
colorscheme badwolf

"set tabs to 4 spaces, soft
set tabstop=4 shiftwidth=4 expandtab
"line numbers
set number
set ruler
"ignore case on searches
set ic
"liberal use of hidden buffers
set hidden

"turn off toolbar and menu
set guioptions-=mcheme
set guioptions-=T
set guioptions-=m

"wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.class,*.git

"search highlight toggle
nnoremap <F2> :set hlsearch!<CR>

"leader key
let mapleader = ","

"Freemarker highlighting
au BufRead,BufNewFile *.ftl set filetype=ftl
au! Syntax ftl source /home/john/.vim/syntax/ftl.vim

"Markdown highlighting
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

"File type detection and indenting
filetype off
syntax on
filetype plugin indent on

"location-list next/previous
map <silent> <A-n> :lnext<CR>
map <silent> <A-p> :lprevious<CR>

"change working directory to current file
map <Leader>cd :cd %:p:h<CR>

"eclim options
"let g:EclimJavaCompilerAutoDetect = 0
let g:EclimProjectTreeSharedInstance = 1
let g:EclimLocateFileScope = 'workspace'
let g:EclimValidateSortResults = 'severity'

"make w, b, and e use CamelCaseMotion
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b
map <silent>e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

"supertab completion type
let g:SuperTabDefaultCompletionType = "context"

"fuzzyfinder options
let g:fuzzy_ceiling = 40000

let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{},
      \                      'MruFile':{}, 'MruCmd':{}, 'Bookmark':{},
      \                      'Tag':{}, 'TaggedFile':{},
      \                      'GivenFile':{}, 'GivenDir':{},
      \                      'CallbackFile':{}, 'CallbackItem':{}, }

let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.class$'

" session.vim settings
let g:session_autosave = "no"
let g:session_autoload = "no"

" rails.vim settings
let g:rails_ctags_arguments='--exclude=.svn --exclude=log /usr/local/share/gems/*'

nmap <silent> <Leader>t :FufFile **/<CR>

"tabular bindings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>

"conque bindings
nmap <Leader>z :ConqueTerm bash<CR>
vmap <Leader>z :ConqueTerm bash<CR>

"fugitive
autocmd QuickFixCmdPost *grep* cwindow

"Ctrl-PageUp/PageDown to move next/previous tabs
nmap <silent> <C-PageDown> gt
nmap <silent> <C-PageUp> gT

"nerdtree bindings
nmap <silent> <Leader>nt :NERDTreeToggle<CR>

"tagbar binding
nmap <silent> <Leader>b :TagbarToggle<CR>

"remove trailing whitespace with F5
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

:nmap <silent><Leader>x :%s/></>\r</g<CR>

"highlight trailing white space in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
