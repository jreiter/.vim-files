" Start up Plug
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/Plug.vim
endif

"Build vim-markdown-composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

call plug#begin('~/.vim/plugged')
 
Plug 'airblade/vim-gitgutter',
Plug 'b4b4r07/vim-hcl',
Plug 'benjaminwhite/Benokai',
Plug 'bfredl/nvim-miniyank',
Plug 'bkad/CamelCaseMotion',
Plug 'bling/vim-airline',
Plug 'chriskempson/base16-vim',
Plug 'ecomba/vim-ruby-refactoring',
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') },
Plug 'eugen0329/vim-esearch',
Plug 'fatih/vim-nginx',
Plug 'flazz/vim-colorschemes',
Plug 'godlygeek/tabular',
Plug 'honza/vim-snippets',
Plug 'idanarye/vim-merginal',
Plug 'itchyny/calendar.vim',
Plug 'juvenn/mustache.vim',
Plug 'justinmk/vim-sneak',
Plug 'majutsushi/tagbar',
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' },
Plug 'mickaobrien/vim-stackoverflow',
Plug 'modille/groovy.vim',
Plug 'nathanaelkane/vim-indent-guides',
Plug 'nelstrom/vim-visual-star-search',
Plug 'neomake/neomake',
Plug 'nikolavp/vim-jape',
Plug 'pangloss/vim-javascript',
Plug 'lokaltog/vim-distinguished',
Plug 'raimondi/delimitMate',
Plug 'rizzatti/dash.vim',
Plug 'roman/golden-ratio',
Plug 'scrooloose/nerdcommenter',
Plug 'shougo/unite.vim',
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'sirVer/ultisnips',
Plug 'skammer/vim-css-color',
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
Plug 'vim-scripts/multiselect',
Plug 'vim-scripts/TailMinusF',
Plug 'xolox/vim-misc'

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
    set guifont=Menlo\ Regular:14
  endif
endif

"Display ruler at 120 characters
if exists('+colorcolumn')
  set colorcolumn=120
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

"python
let g:python_host_prog = '/Users/reiterj/.pyenv/versions/2.7.11/bin/python'
let g:python3_host_prog = '/Users/reiterj/.pyenv/versions/3.4.3/bin/python'

"no swap files
set noswapfile

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

"miniyank settings
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)

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

"neomake settings
let g:neomake_java_enabled_makers = [] 
let g:neomake_error_sign = {'text': '>>', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '>>', 'texthl': 'WarningMsg'}

autocmd! BufWritePost * Neomake

"ultisnips settings
let g:UltiSnipsSnippetDirectories=['vim-snippets/UltiSnips', 'custom_snippets']
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<s-c-j>'

"YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion = 1

"eclim options
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLoggingDisabled = 1

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

" rails.vim settings
let g:rails_ctags_arguments='--exclude=.svn --exclude=log --languages=-javascript'

nnoremap <silent> <Leader>rc :Rake getline('.')<CR>

" unite settings
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1

if executable('ag')
  " Use ag (the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden ' .
  \ '--ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' ' .
  \ '--ignore ''.gradle'' --ignore ''.settings'' --ignore ''.tmp'' --ignore ''.yardoc'' ' .
  \ '--ignore ''bower_components'' --ignore ''node_modules'''
  let g:unite_source_grep_recursive_opt = ''
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom_source('file_rec,file_rec/async', 'max_candidates', 0)
call unite#custom_source('file_rec,file_rec/async,grep',
      \ 'ignore_pattern', join([
      \ 'build/',
      \ 'bin/',
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
      \ '.*\.png'
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
autocmd BufWritePre *.rb,*.erb*,*.js,*.java,*.html,*.css,*.scss :call <SID>StripTrailingWhitespaces()

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

augroup AutoSwap
  autocmd!
  autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
  " if swapfile is older than file itself, just get rid of it
  if getftime(v:swapname) < getftime(a:filename)
    call delete(v:swapname)
    let v:swapchoice = 'e'
  endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
  au!
  if !has("gui_running")
    "silent! necessary otherwise throws errors when using command
    "line window.
    autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
  endif
augroup END
