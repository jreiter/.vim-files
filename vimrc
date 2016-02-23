" Start up Plug
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/Plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter',
Plug 'benjaminwhite/Benokai',
Plug 'bkad/CamelCaseMotion',
Plug 'bling/vim-airline',
Plug 'chriskempson/base16-vim',
Plug 'ecomba/vim-ruby-refactoring',
Plug 'flazz/vim-colorschemes',
Plug 'godlygeek/tabular',
Plug 'honza/vim-snippets',
Plug 'idanarye/vim-merginal',
Plug 'itchyny/calendar.vim',
Plug 'juvenn/mustache.vim',
Plug 'justinmk/vim-sneak',
Plug 'majutsushi/tagbar',
Plug 'marijnh/tern_for_vim',
Plug 'modille/groovy.vim',
Plug 'nathanaelkane/vim-indent-guides',
Plug 'nelstrom/vim-visual-star-search',
Plug 'pangloss/vim-javascript',
Plug 'lokaltog/vim-distinguished',
Plug 'raimondi/delimitMate',
Plug 'roman/golden-ratio',
Plug 'scrooloose/nerdcommenter',
Plug 'scrooloose/syntastic',
Plug 'shougo/unite.vim',
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'shougo/neoyank.vim'
Plug 'sirVer/ultisnips',
Plug 'skammer/vim-css-color',
Plug 'suan/vim-instant-markdown',
Plug 'terryma/vim-multiple-cursors',
Plug 'tpope/vim-bundler',
Plug 'tpope/vim-abolish',
Plug 'tpope/vim-dispatch',
Plug 'tpope/vim-endwise',
Plug 'tpope/vim-fugitive',
Plug 'tpope/vim-haml',
Plug 'tpope/vim-rails',
Plug 'tpope/vim-rake',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-unimpaired',
Plug 'tpope/vim-vinegar',
Plug 'valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-ruby/vim-ruby',
Plug 'vim-scripts/genutils',
Plug 'vim-scripts/grep.vim',
Plug 'vim-scripts/multiselect',
Plug 'vim-scripts/TailMinusF',
Plug 'xolox/vim-misc',
Plug 'xolox/vim-session'

"Add plugins to &runtimepath
call plug#end()

"colors
set t_Co=256
syntax enable

"Always use dark background
set background=dark
let base16colorspace=256
colorscheme base16-monokai

"Set fonts
if has("gui_running")
  if has("gui_win32")
    set guifont=Bitstream_Vera_Sans_Mono:h16:cANSI
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  else
    set guifont=DejaVu\ Sans\ Mono\ \Bold\ 11
  endif
endif

"set tabs to 2 spaces, soft
set tabstop=2 shiftwidth=2 expandtab
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
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.class,*.git

"turn on matchit
runtime macros/matchit.vim

"search highlight toggle
nnoremap <F2> :set hlsearch!<CR>

"leader key
let mapleader = ","

"File type detection and indenting
syntax on
filetype plugin indent on

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"change working directory to current file
map <Leader>cd :cd %:p:h<CR>

"golden-ratio settings
let g:golden_ratio_autocommand = 0

"calendar settings
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

"indent guides settings
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'calendar']

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey30 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey15 ctermbg=242

"syntastic settings
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"ultisnips settings
let g:UltiSnipsSnippetDirectories=['Ultisnips', 'custom_snippets']
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<s-c-j>'

"eclim options
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLocateFileScope = 'workspace'
let g:EclimProjectTreeSharedInstance = 1
let g:EclimValidateSortResults = 'severity'

"make w, b, and e use CamelCaseMotion
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b
map <silent>e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Show airline without split buffers
set laststatus=2

" sneak.vim settings
let g:sneak#streak = 1

" session.vim settings
let g:session_autosave = "no"
let g:session_autoload = "no"

" rails.vim settings
let g:rails_ctags_arguments='--exclude=.svn --exclude=log --languages=-javascript'

nnoremap <silent> <Leader>rc :Rake getline('.')<CR>

" unite settings
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom_source('file_rec,file_rec/async', 'max_candidates', 0)
call unite#custom_source('file_rec,file_rec/async,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.gradle/',
      \ '\.sass-cache/',
      \ '\.settings/',
      \ '\.svn/',
      \ '\.tmp/',
      \ '\.yardoc/',
      \ 'bower_components/',
      \ 'dist/',
      \ 'node_modules/',
      \ 'coverage/',
      \ 'doc/.*/.*\.html',
      \ 'docs/html/.*',
      \ 'docs/generated/.*',
      \ 'tmp/',
      \ 'tags',
      \ '.*\.log',
      \ '.*\.png',
      \ ], '\|'))

" unite bindings
nnoremap <silent> <Leader>t :Unite -start-insert file_rec/async<CR>
nnoremap <space>/ :Unite -no-quit -buffer-name=search grep:.<CR>
nnoremap <space>s :Unite buffer<cr>

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

"tagbar binding
nmap <silent> <Leader>b :TagbarToggle<CR>

"remove trailing whitespace with F5
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

"automatically remove trailing whitespace when saving files
autocmd BufWritePre *.rb,*.erb*,*.js,*.html,*.css,*.scss :call <SID>StripTrailingWhitespaces()

" search with explicitly provided arguments
command! -n=? Rgrep :call RailsScriptSearch('<args>')

" search for the word under the cursor
map <leader>rg :silent call RailsScriptSearch(expand("<cword>"))<CR>:cc<CR>

" search for the method definition of the word under the cursor
map <leader>rd :silent call RailsScriptSearch(expand("'def .*<cword>'"))<CR>:cc<CR>

"function for stripping trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
