" Start up Plug
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/Plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter',
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'bfredl/nvim-miniyank',
Plug 'bkad/CamelCaseMotion',
Plug 'bling/vim-airline',
Plug 'briancollins/vim-jst',
Plug 'chriskempson/base16-vim',
Plug 'digitaltoad/vim-pug',
Plug 'ecomba/vim-ruby-refactoring',
Plug 'elzr/vim-json',
Plug 'eugen0329/vim-esearch',
Plug 'fatih/vim-nginx',
Plug 'godlygeek/tabular',
Plug 'hallison/vim-rdoc',
Plug 'HerringtonDarkholme/yats.vim',
Plug 'honza/vim-snippets',
Plug 'janko-m/vim-test',
Plug 'jiangmiao/auto-pairs',
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' },
Plug 'junegunn/fzf.vim',
Plug 'justinmk/vim-sneak',
Plug 'majutsushi/tagbar',
Plug 'moll/vim-node',
Plug 'mustache/vim-mustache-handlebars',
Plug 'heavenshell/vim-jsdoc',
Plug 'modille/groovy.vim',
Plug 'mxw/vim-jsx',
Plug 'nathanaelkane/vim-indent-guides',
Plug 'nelstrom/vim-visual-star-search',
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neovim/node-host', { 'do': 'npm install' },
Plug 'nikolavp/vim-jape',
Plug 'pangloss/vim-javascript',
Plug 'Quramy/tsuquyomi',
Plug 'rizzatti/dash.vim',
Plug 'scrooloose/nerdcommenter',
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'shumphrey/fugitive-gitlab.vim',
Plug 'skywind3000/asyncrun.vim',
Plug 'tpope/vim-bundler',
Plug 'tpope/vim-abolish',
Plug 'tpope/vim-cucumber',
Plug 'tpope/vim-dispatch',
Plug 'tpope/vim-endwise',
Plug 'tpope/vim-fugitive',
Plug 'tpope/vim-haml',
Plug 'tpope/vim-projectionist',
Plug 'tpope/vim-rails',
Plug 'tpope/vim-rake',
Plug 'tpope/vim-rbenv',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-unimpaired',
Plug 'tpope/vim-vinegar',
Plug 'vim-ruby/vim-ruby',
Plug 'vim-scripts/genutils',
Plug 'vim-scripts/TailMinusF',
Plug 'w0rp/ale',
Plug 'xolox/vim-misc'

"Add plugins to &runtimepath
call plug#end()

"colors
set t_Co=256
syntax enable

"Always use dark background
set background=dark

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"Set fonts
if has("gui_running")
  if has("gui_win32")
    set guifont=Bitstream_Vera_Sans_Mono:h16:cANSI
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  else
    set guifont=Menlo\ Regular:h14
  endif
endif

"Display ruler at 80 characters
if exists('+colorcolumn')
  set colorcolumn=80
endif

"auto-select completions
"set completeopt+=noinsert
"set completeopt+=preview

let g:LanguageClient_autoStart = 1
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

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

"allow live substitution
set inccommand=nosplit

"python
let g:python_host_prog = $HOME.'/.pyenv/shims/python'
let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'

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

"Use +/- for resizing windows by a sane amount
map <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"vim-test settings
let test#strategy = 'neovim'
let test#javascript#jasmine#executable = 'ndb node_modules/jasmine/bin/jasmine.js'
let test#javascript#jest#executable = 'ndb node_modules/jest/bin/jest.js'

"copying to os clipboard
map <leader>y "*y
map <leader>Y "+y

"miniyank settings
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)

"indent guides settings
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'calendar']

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey30 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey15 ctermbg=242

"jsdoc settings
let g:jsdoc_enable_es6=1

"vim-javascript settings
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

"ale settings
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint', 'remove_trailing_lines'],
                    \'ruby': ['rubocop', 'remove_trailing_lines'],
                    \'markdown': ['prettier', 'remove_trailing_lines']}
let g:ale_sign_warning = '>>'
highlight ALEWarning ctermbg=100
highlight ALEError ctermbg=Red

let g:coc_user_config = {
      \ 'snippets.extends': {
      \   'javascriptreact': ['javascript'],
      \   'gitcommit_markdown': ['gitcommit']
      \ },
      \ 'snippets.ultisnips.directories': [
      \   'UltiSnips'
      \ ]
      \ }

"eclim options
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLoggingDisabled = 1
let g:EclimJavascriptValidate = 0

"make w, b, and e use CamelCaseMotion
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b
map <silent>e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Show airline without split buffers
set laststatus=2
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#branch#format = 2

" sneak.vim settings
let g:sneak#streak = 1

" rails.vim settings
let g:rails_ctags_arguments='--exclude=.svn --exclude=log --languages=-javascript'

" fzf settings/bindings
let g:fzf_history_dir = '~/.fzf-history'
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <space>/ :Ag
nnoremap <space>s :Buffers<CR>

"tabular bindings
map <Leader>a= :Tabularize /=<CR>
map <Leader>a: :Tabularize /:\zs<CR>
map <Leader>a, :Tabularize /,\zs<CR>

"fugitive
autocmd QuickFixCmdPost *grep* cwindow

"tagbar binding
nmap <silent> <Leader>b :TagbarToggle<CR>

"automatically remove trailing whitespace when saving files
autocmd BufWritePre :call <SID>StripTrailingWhitespaces()

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

"Handle reloading files if they are changed outside of the editor: https://github.com/neovim/neovim/issues/2127
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
