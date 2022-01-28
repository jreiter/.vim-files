" Start up Plug
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/Plug.vim
endif

call plug#begin('~/.vim/plugged')

"debugging
Plug 'Pocco81/DAPInstall.nvim'
Plug 'mfussenegger/nvim-dap',
Plug 'theHamsta/nvim-dap-virtual-text'
"lsp
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'tami5/lspsaga.nvim'
"completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
"snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
"telescope
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
"testing
Plug 'David-Kunz/jester'
Plug 'janko-m/vim-test',
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-cucumber',
"git
Plug 'airblade/vim-gitgutter',
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'
"async
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'skywind3000/asyncrun.vim',
Plug 'tpope/vim-dispatch',
"ruby
Plug 'hallison/vim-rdoc',
Plug 'tpope/vim-bundler',
Plug 'tpope/vim-rails',
Plug 'tpope/vim-rake',
Plug 'tpope/vim-rbenv',
Plug 'vim-ruby/vim-ruby',
"javascript
Plug 'briancollins/vim-jst',
Plug 'elzr/vim-json',
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'moll/vim-node'
Plug 'neovim/node-host', { 'do': 'npm install' },
"language/syntax
Plug 'fatih/vim-nginx',
Plug 'modille/groovy.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
Plug 'tpope/vim-haml',
"markdown
Plug 'dhruvasagar/vim-marp'
Plug 'mattf1n/vimmarp'
"misc
Plug 'HerringtonDarkholme/yats.vim',
Plug 'OmniSharp/omnisharp-vim'
Plug 'Quramy/tsuquyomi',
Plug 'andymass/vim-matchup'
Plug 'bfredl/nvim-miniyank'
Plug 'bkad/CamelCaseMotion'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim',
Plug 'ggandor/lightspeed.nvim',
Plug 'godlygeek/tabular',
Plug 'liuchengxu/vista.vim',
Plug 'nelstrom/vim-visual-star-search',
Plug 'numToStr/Comment.nvim'
Plug 'rhysd/vim-grammarous',
Plug 'rizzatti/dash.vim',
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-abolish',
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-endwise',
Plug 'tpope/vim-projectionist',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-unimpaired',
Plug 'tpope/vim-vinegar',
Plug 'vim-scripts/genutils'
Plug 'voldikss/vim-floaterm'
Plug 'xolox/vim-misc'

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

" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" autocmd BufNewFile,BufReadPost *.dialog set filetype=json

"Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'asyncrun_background',
  \ 'suite':   'neovim',
\}

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F10> :lua require'dap'.close()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

"ultest
let g:ultest_use_pty = 1
let g:ultest_virtual_text = 1
nmap <silent> t<C-d> :UltestDebugNearest<CR>

function! UltestFile()
  if test#test_file(expand('%'))
    Ultest
  elseif test#test_file(s:alternate_file())
    " figure out how to run tests from the alternate file
  endif
endfunction

augroup ultest
  au!
  au BufWritePost *.js Ultest
augroup END

augroup test
  autocmd!
  autocmd BufWrite *.rb if test#exists() |
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

nnoremap <leader>qf :call ToggleQuickFix()<cr>
nnoremap <leader>qt :Trouble<cr>

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
