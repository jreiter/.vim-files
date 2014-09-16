" Start up neobundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

set rtp+=~/.vim/bundle/neobundle
call neobundle#begin(expand('~/.vim/neobundle'))

NeoBundleFetch 'Shuogo/neobundle.vim'

NeoBundle 'airblade/vim-gitgutter.git',          { 'directory': 'git-gutter' }
NeoBundle 'bling/vim-airline.git',               { 'directory': 'airline' }
NeoBundle 'ecomba/vim-ruby-refactoring.git',     { 'directory': 'ruby-refactoring' }
NeoBundle 'godlygeek/tabular.git',               { 'directory': 'tabular' }
NeoBundle 'honza/vim-snippets.git',              { 'directory': 'ultisnips-snippets' }
NeoBundle 'itchyny/calendar.vim.git',            { 'directory': 'calendar' }
NeoBundle 'juvenn/mustache.vim.git',             { 'directory': 'mustache' }
NeoBundle 'justinmk/vim-sneak.git',              { 'directory': 'sneak' }
NeoBundle 'majutsushi/tagbar.git',               { 'directory': 'tagbar' }
NeoBundle 'marijnh/tern_for_vim.git',            { 'directory': 'tern' }
NeoBundle 'nathanaelkane/vim-indent-guides.git', { 'directory': 'indent-guides' }
NeoBundle 'nelstrom/vim-visual-star-search.git', { 'directory': 'visual-star-search' }
NeoBundle 'pangloss/vim-javascript.git',         { 'directory': 'javascript' }
NeoBundle 'Lokaltog/vim-distinguished.git',      { 'directory': 'distinguished' }
NeoBundle 'Raimondi/delimitMate.git',            { 'directory': 'delimit-mate' }
NeoBundle 'roman/golden-ratio.git',              { 'directory': 'golden-ratio' }
NeoBundle 'scrooloose/nerdcommenter.git',        { 'directory': 'nerdcommenter' }
NeoBundle 'scrooloose/syntastic.git',            { 'directory': 'syntastic' }
NeoBundle 'Shougo/unite.vim.git',                { 'directory': 'unite' }
NeoBundle 'Shougo/vimproc.vim.git',              { 'directory': 'vimproc',
                                               \   'build': {
                                               \     'mac':  'make -f make_mac.mak',
                                               \     'unix': 'make -f make_unix.mak'
                                               \    },
                                               \ }
NeoBundle 'sjl/badwolf.git',                     { 'directory': 'badwolf' }
NeoBundle 'SirVer/ultisnips.git',                { 'directory': 'ultisnips' }
NeoBundle 'skammer/vim-css-color.git',           { 'directory': 'css-color' }
NeoBundle 'suan/vim-instant-markdown.git',       { 'directory': 'instant-markdown' }
NeoBundle 'terryma/vim-multiple-cursors.git',    { 'directory': 'multiple-cursors' }
NeoBundle 'tomasr/molokai.git',                  { 'directory': 'molokai' }
NeoBundle 'tpope/vim-bundler.git',               { 'directory': 'bundler' }
NeoBundle 'tpope/vim-abolish.git',               { 'directory': 'abolish' }
NeoBundle 'tpope/vim-dispatch.git',              { 'directory': 'dispatch' }
NeoBundle 'tpope/vim-endwise.git',               { 'directory': 'endwise' }
NeoBundle 'tpope/vim-fugitive.git',              { 'directory': 'fugitive' }
NeoBundle 'tpope/vim-haml.git',                  { 'directory': 'haml' }
NeoBundle 'tpope/vim-rails.git',                 { 'directory': 'rails' }
NeoBundle 'tpope/vim-rake.git',                  { 'directory': 'rake' }
NeoBundle 'tpope/vim-surround.git',              { 'directory': 'surround' }
NeoBundle 'tpope/vim-unimpaired.git',            { 'directory': 'unimpaired' }
NeoBundle 'tpope/vim-vinegar.git',               { 'directory': 'vinegar' }
NeoBundle 'Valloric/YouCompleteMe.git',          { 'directory': 'you-complete-me',
                                               \   'build': {
                                               \     'mac':  './install.sh --clang-completer',
                                               \     'unix': './install.sh --clang-completer'
                                               \    },
                                               \ }
NeoBundle 'vim-ruby/vim-ruby.git',               { 'directory': 'ruby' }
NeoBundle 'vim-scripts/genutils.git',            { 'directory': 'genutils' }
NeoBundle 'vim-scripts/grep.vim.git',            { 'directory': 'grep' }
NeoBundle 'vim-scripts/multiselect.git',         { 'directory': 'multiselect' }
NeoBundle 'vim-scripts/TailMinusF.git',          { 'directory': 'tail-minus-f' }
NeoBundle 'xolox/vim-misc.git',                  { 'directory': 'misc' }
NeoBundle 'xolox/vim-session.git',               { 'directory': 'session' }

call neobundle#end()

NeoBundleCheck

"colors
set t_Co=256
syntax enable
colorscheme badwolf

"Set fonts
if has("gui_running")
  if has("gui_win32")
    set guifont=Bitstream_Vera_Sans_Mono:h16:cANSI
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h13
  else
    set guifont=DejaVu\ Sans\ Mono\ 9
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
filetype off
syntax on
filetype plugin indent on

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"change working directory to current file
map <Leader>cd :cd %:p:h<CR>

"calendar settings
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

"indent guides settings
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'calendar']

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey30 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey15 ctermbg=242

"syntastic settings
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"ultisnips settings
let g:UltiSnipsSnippetDirectories=['snippets/UltiSnips', 'custom_snippets']
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<s-c-j>'

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
      \ '\.svn/',
      \ '\.yardoc/',
      \ 'coverage/',
      \ 'tmp/',
      \ 'tags',
      \ '.*\.log',
      \ 'doc/.*/.*\.html',
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

"nerdtree bindings
nmap <silent> <Leader>nt :NERDTreeToggle<CR>

"tagbar binding
nmap <silent> <Leader>b :TagbarToggle<CR>

"remove trailing whitespace with F5
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

"automatically remove trailing whitespace when saving files
autocmd BufWritePre *.rb,*.erb*,.js,*.html,*.css,*.scss :call <SID>StripTrailingWhitespaces()

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
