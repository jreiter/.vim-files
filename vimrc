" Start up Plugticket_visit
if has('vim_starting')
  set runtimepath+=~/.vim
endif

call plug#begin('~/.vim/plugged')

"debugging
Plug 'Pocco81/dap-buddy.nvim', { 'branch': 'dev' }
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/cmp-dap'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'suketa/nvim-dap-ruby'
Plug 'Pocco81/DAPInstall.nvim'
"lsp
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'lvimuser/lsp-inlayhints.nvim', { 'branch': 'anticonceal' }
"completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
"snippets
Plug 'L3MON4D3/LuaSnip', { 'do': 'make install_jsregexp' }
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
"telescope
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope.nvim'
"testing
Plug 'vim-test/vim-test'
Plug 'nvim-neotest/neotest'
Plug 'haydenmeade/neotest-jest'
Plug 'olimorris/neotest-rspec'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'tpope/vim-cucumber'
"git
Plug 'lewis6991/gitsigns.nvim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'
Plug 'pwntester/octo.nvim'
"async
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'skywind3000/asyncrun.vim',
Plug 'tpope/vim-dispatch'
"ruby
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rbenv'
Plug 'vim-ruby/vim-ruby'
"javascript
Plug 'briancollins/vim-jst',
Plug 'elzr/vim-json',
"language/syntax
Plug 'fatih/vim-nginx'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
Plug 'tpope/vim-haml'
Plug 'towolf/vim-helm'
"color schemes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"notes
Plug 'renerocksai/telekasten.nvim'
Plug 'renerocksai/calendar-vim'
"misc
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MunifTanjim/nui.nvim'
Plug 'Quramy/tsuquyomi'
Plug 'SmiteshP/nvim-navbuddy'
Plug 'SmiteshP/nvim-navic'
Plug 'andymass/vim-matchup'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'bfredl/nvim-miniyank'
Plug 'bkad/CamelCaseMotion'
Plug 'danymat/neogen'
Plug 'echasnovski/mini.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'ggandor/leap.nvim'
Plug 'godlygeek/tabular'
Plug 'luckasRanarison/nvim-devdocs'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'rhysd/vim-grammarous'
Plug 'simrat39/symbols-outline.nvim'
Plug 'stevearc/oil.nvim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tzachar/local-highlight.nvim'
Plug 'vim-scripts/genutils'
Plug 'voldikss/vim-floaterm'
Plug 'xolox/vim-misc'

"Add plugins to &runtimepath
call plug#end()

set updatetime=500

"Always use dark background
set background=dark

"colors
set t_Co=256
syntax enable

set termguicolors
let g:tokyonight_style = "storm"
colorscheme catppuccin-macchiato

"Display ruler at 80 characters
if exists('+colorcolumn')
  set colorcolumn=80
endif

"auto-select completions
set completeopt+=noinsert
set completeopt+=preview

" let g:LanguageClient_autoStart = 1

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
let g:python3_host_prog = $HOMEBREW_PREFIX.'/bin/python3'

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
autocmd BufNewFile,BufReadPost *.attack set filetype=cucumber

"Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"DAP
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.step_back()<CR>
nnoremap <silent> <F10> :lua require'dap'.close()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>E :lua require'dap'.set_exception_breakpoints()<CR>
nnoremap <silent> <leader>dr :lua require'dapui'.float_element('repl', { width = 100, height = 40, enter = true })<CR>
nnoremap <silent> <leader>ds :lua require'dapui'.float_element('scopes', { width = 150, height = 50, enter = true })<CR>
nnoremap <silent> <leader>df :lua require'dapui'.float_element('stacks', { width = 150, height = 50, enter = true })<CR>
nnoremap <silent> <leader>db :lua require'dapui'.float_element('breakpoints', { enter = true })<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

"neotest
nmap <silent> t<C-d> :lua require('neotest').run.run({strategy = 'dap'})<CR>
nmap <silent> t<C-n> :lua require('neotest').run.run()<CR>
nmap <silent> t<C-f> :lua require('neotest').run.run(vim.fn.expand('%'))<CR>
nmap <silent> t<C-s> :lua require('neotest').summary.open()<CR>
nmap <silent> t<C-o> :lua require('neotest').output_panel.toggle()<CR>

let test#strategy = 'floaterm'

autocmd FileType qf wincmd J

" devdocs
nnoremap <silent> <leader>dd :DevdocsOpenFloat<CR>
nnoremap <silent> <leader>dc :DevdocsOpenCurrentFloat<CR>

"telekasten
nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
nnoremap <leader>zC :CalendarT<CR>
nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
" Toggling todos in visual mode
vnoremap <leader>zt :lua require('telekasten').toggle_todo({ v = true })<CR>
nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
nnoremap <leader># :lua require('telekasten').show_tags()<CR>

" we could define [[ in **insert mode** to call insert link
" inoremap [[ <ESC>:lua require('telekasten').insert_link()<CR>
" alternatively: leader [
inoremap <leader>[ <ESC>:lua require('telekasten').insert_link({ i=true })<CR>
inoremap <leader>zt <ESC>:lua require('telekasten').toggle_todo({ i=true })<CR>
inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>

"telescope
nnoremap <silent> <Leader>t :Telescope find_files<CR>
nnoremap <space>f :Telescope live_grep<CR>
nnoremap <space>s :Telescope buffers<CR>

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

" floaterm settings
let g:floaterm_keymap_new    = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_toggle = '<F4>'

tnoremap jk <c-\><c-n>

"tabular bindings
map <Leader>a= :Tabularize /=<CR>
map <Leader>a: :Tabularize /:\zs<CR>
map <Leader>a, :Tabularize /,\zs<CR>

"base64 decode
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

"fugitive
autocmd QuickFixCmdPost *grep* cwindow

"vista binding
nmap <silent> <Leader>v :Vista!!<CR>

lua require('jreiter')
