" Start up Plug
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/Plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'bfredl/nvim-miniyank',
Plug 'bkad/CamelCaseMotion',
Plug 'bling/vim-airline',
Plug 'briancollins/vim-jst',
Plug 'chriskempson/base16-vim',
Plug 'digitaltoad/vim-pug',
Plug 'ecomba/vim-ruby-refactoring',
Plug 'elzr/vim-json',
Plug 'fatih/vim-nginx',
Plug 'godlygeek/tabular',
Plug 'hallison/vim-rdoc',
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'HerringtonDarkholme/yats.vim',
Plug 'honza/vim-snippets',
Plug 'janko-m/vim-test',
Plug 'jiangmiao/auto-pairs',
Plug 'ggandor/lightspeed.nvim',
Plug 'liuchengxu/vista.vim',
Plug 'mfussenegger/nvim-dap',
Plug 'Pocco81/DAPInstall.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'David-Kunz/jester'
Plug 'dhruvasagar/vim-marp'
Plug 'mattf1n/vimmarp'
Plug 'moll/vim-node'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
Plug 'modille/groovy.vim'
Plug 'nelstrom/vim-visual-star-search',
Plug 'neovim/node-host', { 'do': 'npm install' },
Plug 'OmniSharp/omnisharp-vim'
Plug 'Quramy/tsuquyomi',
Plug 'rizzatti/dash.vim',
Plug 'rhysd/vim-grammarous',
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'skywind3000/asyncrun.vim',
Plug 'tpope/vim-bundler',
Plug 'tpope/vim-abolish',
Plug 'tpope/vim-cucumber',
Plug 'tpope/vim-dispatch',
Plug 'tpope/vim-endwise',
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
Plug 'voldikss/vim-floaterm'
Plug 'xolox/vim-misc'
"telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"icons
Plug 'kyazdani42/nvim-web-devicons'
"lsp
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/lsp-colors.nvim'
"messages
Plug 'folke/trouble.nvim'
"completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
"git
Plug 'airblade/vim-gitgutter',
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'
"comments
Plug 'numToStr/Comment.nvim'

"Add plugins to &runtimepath
call plug#end()

"Always use dark background
set background=dark

"colors
set t_Co=256
syntax enable

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set termguicolors

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
set completeopt+=noinsert
set completeopt+=preview

let g:LanguageClient_autoStart = 1

"set tabs to 2 spaces, soft
set tabstop=2 shiftwidth=2 expandtab
"line numbers
set number
set ruler
"ignore case on searches
set ic
"liberal use of hidden buffers
set hidden
"smart indent
set autoindent smartindent

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

"leader key
let mapleader = ","

"File type detection and indenting
syntax on
filetype plugin indent on

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.dialog set filetype=json

"Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"vim-test settings
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'asyncrun_background',
  \ 'suite':   'neovim',
\}

function! DebugJest()
  lua require'jester'.debug()
endfunction

nmap <silent> t<C-d> :call DebugJest()<CR>

function! ContinueDebug()
  lua require'dap'.continue()
endfunction

nnoremap <silent> <F5> :call ContinueDebug()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F10> :lua require'dap'.close()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

augroup test
  autocmd!
  autocmd BufWrite *.js,*.rb if test#exists() |
    \   TestFile |
    \ endif
augroup END

autocmd FileType qf wincmd J

"telescope
nnoremap <silent> <Leader>t :Telescope find_files<CR>
nnoremap <space>/ :Telescope live_grep<CR>
nnoremap <space>s :Telescope buffers<CR>

" Quickfix
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>q :call ToggleQuickFix()<cr>

"copying to os clipboard
map <leader>y "*y
map <leader>Y "+y

"miniyank settings
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)

" GoTo code navigation.
nmap <silent> gd :Telescope lsp_definitions<CR>
nmap <silent> gy :Telescope lsp_type_definitions<CR>
nmap <silent> gi :Telescope lsp_implementations<CR>
nmap <silent> gr :Telescope lsp_references<CR>
nmap <silent> <space>ca :Lspsaga code_actions<CR>
" Rename symbol
nmap <leader>rn :Lspsaga rename<CR>

nnoremap <silent> K :Lspsaga hover_doc<CR>

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

" floaterm settings
let g:floaterm_keymap_new    = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_toggle = '<F4>'

"tabular bindings
map <Leader>a= :Tabularize /=<CR>
map <Leader>a: :Tabularize /:\zs<CR>
map <Leader>a, :Tabularize /,\zs<CR>

"fugitive
autocmd QuickFixCmdPost *grep* cwindow

"vista binding
nmap <silent> <Leader>v :Vista!!<CR>

lua require('jreiter')
