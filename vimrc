runtime pathogen_init

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

"Markdown highlighting
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

"File type detection and indenting
filetype off
syntax on
filetype plugin indent on

"change working directory to current file
map <Leader>cd :cd %:p:h<CR>

"indent guides settings
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"syntastic ruby settings
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_warnings = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"highlight trailing white space in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! RailsScriptSearch(args)
  let l:savegrepprg = &grepprg
  let l:savegrepformat = &grepformat

  try
    set grepprg=script/find
    set grepformat=%f:%l:%m

    execute "grep " . a:args
  finally
    execute "set grepformat=" . l:savegrepformat
    execute "set grepprg=" . l:savegrepprg
  endtry
endfunction

" search with explicitly provided arguments
command! -n=? Rgrep :call RailsScriptSearch('<args>')

" search for the word under the cursor
map <leader>rg :silent call RailsScriptSearch(expand("<cword>"))<CR>:cc<CR>

" search for the method definition of the word under the cursor
map <leader>rd :silent call RailsScriptSearch(expand("'def .*<cword>'"))<CR>:cc<CR>
